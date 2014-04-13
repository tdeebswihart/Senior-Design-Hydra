# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_fedora/version"

Gem::Specification.new do |s|
  s.name        = "active-fedora"
  s.version     = ActiveFedora::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Zumwalt", "McClain Looney", "Justin Coyne"]
  s.email       = ["matt.zumwalt@yourmediashelf.com"]
  s.homepage    = %q{https://github.com/projecthydra/active_fedora}
  s.summary     = %q{A convenience libary for manipulating documents in the Fedora Repository.}
  s.description = %q{ActiveFedora provides for creating and managing objects in the Fedora Repository Architecture.}
  s.license = "APACHE2"
  s.required_ruby_version     = '>= 1.9.3'

  s.add_dependency('rsolr', "~> 1.0.10.pre1")
  s.add_dependency('om', '~> 3.0.0')
  s.add_dependency('nom-xml', '>=0.5.1')
  s.add_dependency("activesupport", '>= 3.0.0')
  s.add_dependency("mediashelf-loggable")
  s.add_dependency("rubydora", '~>1.7.4')
  s.add_dependency("linkeddata")
  s.add_dependency("rdf-rdfxml", '~>1.1.0')
  s.add_dependency("deprecation")
  s.add_development_dependency("rdoc")
  s.add_development_dependency("yard")
  s.add_development_dependency("rake")
  s.add_development_dependency("jettywrapper", ">=1.4.0")
  s.add_development_dependency("rspec", ">= 2.9.0")
  s.add_development_dependency("equivalent-xml")
  s.add_development_dependency("rest-client")
  s.add_development_dependency("webmock")
  s.add_development_dependency("simplecov", '~> 0.7.1')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.require_paths = ["lib"]

end

