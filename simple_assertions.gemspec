# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_assertions"

Gem::Specification.new do |s|
  s.name        = "simple_assertions"
  s.version     = SimpleAssertions::VERSION
  s.authors     = ["Peter Suschlik"]
  s.email       = ["ps@neopoly.de"]
  s.homepage    = "https://github.com/neopoly/simple_assertions"
  s.summary     = %q{Useful assertions for test/unit}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "test-unit"
end
