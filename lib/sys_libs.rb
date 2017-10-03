require "sys_libs/version"
require "rest-client"
require "json"

module SysLibs
    class Task
        #Read the project's Gemfile, fetch all uncommented gems and add to array
        def getPackages
            @packagesArray = []
            f = File.open("Gemfile", "r")
            f.each_line do |line|
              if !line.include?"#" and line.include? "gem" and !line.include?"rubygems.org" and !line.include? "gemspec"
                name = line.split(" ")[1].slice(1..-2)
                if name[-1].chr == "'"
                  name = name.slice(0..-2)
                end
                @packagesArray << (name)
              end
            end
            f.close
            return @packagesArray
        end

        #Get the current os
        def getOS
            @os ||= (
              host_os = RbConfig::CONFIG['host_os']
              case host_os
              when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
                :windows
              when /darwin|mac os/
                :mac
              when /linux/
                :linux
              when /solaris|bsd/
                :unix
              else
                raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
              end
            )
        end

        #Send a post request to the server to retrieve the required sys libs
        def getMissingLibs(packagesArray, os)
            response = RestClient.post "https://eventtus-task.herokuapp.com/packages/search", 
                                { :packages => packagesArray, :os => os }
            body = JSON.parse(response.body)
            body.each do |key, value|
                puts key["name"] + " needs the following sys libs to be installed:"
                key["dependencies"].each do |d|
                    puts d["name"]
                end
                puts "Trying to download the required libs..."
                key["dependencies"].each do |d|
                    case key["os"]
                        when "mac"
                        system("brew install "+ d["name"])
                        when "linux"
                        system("apt-get install "+ d["name"])
                        when "unix"
                        system("apt-get install "+ d["name"])
                        else
                        puts "It is recommended you download those libs before proceeding."
                    end
                end
            end
        end
    end
end
