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
    
    
end
