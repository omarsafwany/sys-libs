# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sys_libs/version"

Gem::Specification.new do |spec|
  spec.name          = "sys_libs"
  spec.version       = SysLibs::VERSION
  spec.authors       = ["Omar Safwany"]
  spec.email         = ["omar.safwany@gmail.com"]

  spec.summary       = %q{A gem that lists all missing system libraries to install.}
  spec.description   = %q{A gem that lists the missing system libraries by project's gems to install and avoid getting errors.}
#  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["sys_libs"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"
    
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"    
end
