#require "sys_libs/version"
require "unirest"

module SysLibs
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
    
    response = RestClient.post "http://localhost:3000/packages/search", 
                        { :packages => @packagesArray, :os => @os }
    body = JSON.parse(response.body)
    body.each do |key, value|
        puts key["name"] + " needs the following sys libs to be installed:"
        key["dependencies"].each do |d|
            puts d["name"]
        end
    end
end
