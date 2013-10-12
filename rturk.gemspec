# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rturk/version"

Gem::Specification.new do |s|
  s.name = 'rturk'
  s.version = RTurk::VERSION
  s.homepage = "http://github.com/mdp/rturk"
  s.summary = "Mechanical Turk API Wrapper"

  s.authors = ["Mark Percival", "Zach Hale", "David Balatero", "Rob Hanlon"]
  s.date = "2013-08-19"
  s.email = "m@mdp.im"
  s.license = 'MIT'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]

  s.require_paths = ["lib"]
  s.rubygems_version = "1.7.2"

  s.rubyforge_project = "pulley"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('rest-client')
  s.add_dependency('nokogiri')
  s.add_dependency('erector')

  # Development dependencies
  s.add_development_dependency('rspec', "~> 1.3.1")
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('webmock')
end
