# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "simple_assertions"

Gem::Specification.new do |s|
  s.name        = "simple_assertions"
  s.version     = SimpleAssertions::VERSION
  s.authors     = ["Peter Suschlik"]
  s.email       = ["ps@neopoly.de"]
  s.homepage    = "https://github.com/neopoly/simple_assertions"
  s.summary     = "A collection of useful assertions."
  s.description = s.summary

  s.required_ruby_version = ">= 2.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rake"
  s.add_runtime_dependency "rdoc"

  s.add_development_dependency "minitest", "~> 5.5.1"
  s.add_development_dependency "activemodel", "~> 4.2.1"
end
