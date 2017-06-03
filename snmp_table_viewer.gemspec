# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.join(File.dirname(__FILE__), 'version')

Gem::Specification.new do |s|
  s.name        = "snmp_table_viewer"
  s.license     = 'BSD 3 clause'
  s.version     = SNMPTableViewer::VERSION
  s.authors     = ['Robert Gauld']
  s.email       = ['robert@robertgauld.co.uk']
  s.homepage    = 'https://github.com/robertgauld/snmp-table-viewer'
  s.summary     = %q{Easily view SNMP tables.}
  s.description = %q{Easily view SNMP tables in a variety of different formats including as a table in the terminal, json or csv.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'netsnmp', '~> 0.1.3'
  s.add_runtime_dependency 'terminal-table', '~> 1.8.0'

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '>= 2.14.1', '< 4'
  s.add_development_dependency 'guard-rspec', '~> 4.2', '>= 4.2.5'
  s.add_development_dependency 'rb-inotify', '~> 0.9'
  s.add_development_dependency 'coveralls', '~> 0.7'
  s.add_development_dependency 'simplecov', '~> 0.7'

end
