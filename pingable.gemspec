# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "pingable/version"

Gem::Specification.new do |s|
  s.name        = "pingable"
  s.version     = Pingable::VERSION
  s.authors     = ["Alexander Staubo"]
  s.email       = ["alex@origo.no"]
  s.homepage    = "http://github.com/origo/pingable"
  s.summary     = s.description = %q{Pingable is a Rack handler that let an app respond to a path /ping, with pluggable checks}

  s.rubyforge_project = "pingable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  
  s.add_runtime_dependency "rack", '>= 1.0.0'
end
