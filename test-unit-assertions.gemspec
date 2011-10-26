# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "test-unit-assertions/version"

Gem::Specification.new do |s|
  s.name        = "test-unit-assertions"
  s.version     = Test::Unit::Assertions::VERSION
  s.authors     = ["Peter Suschlik"]
  s.email       = ["ps@neopoly.de"]
  s.homepage    = "https://github.com/neopoly/test-unit-assertions"
  s.summary     = %q{Useful assertions for test/unit}
  s.description = %q{}

  s.rubyforge_project = "test-unit-assertions"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "test-unit"
end
