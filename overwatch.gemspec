# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'overwatch/version'

Gem::Specification.new do |s|
  s.name              = 'overwatch'
  s.version           = Overwatch::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = [ "Dan Ryan" ]
  s.email             = [ "dan@appliedawesome.com" ]
  s.homepage          = "https://github.com/danryan/overwatch-client"
  s.summary           = "Overwatch command-line interface for configuration and reporting"
  s.description       = "overwatch is the command-line interface to the Overwatch monitoring suite"
  
  s.rubyforge_project = "overwatch"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {spec}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.add_dependency 'yajl-ruby', '>= 0.8.2'
  s.add_dependency 'rest-client', '>= 1.6.3'
  s.add_dependency 'clamp', '>= 0.2.2'
  s.add_dependency 'formatador', '>= 0.2.0'
  s.add_dependency 'hirb', '>= 0.4.5'
  s.add_dependency 'ohai'
  
  s.add_development_dependency 'rspec', '>= 2.6.0'
  s.add_development_dependency 'spork', '>= 0.9.0.rc8'
  s.add_development_dependency 'watchr', '>= 0.7'
  s.add_development_dependency 'json_spec', '>= 0.5.0'
end
