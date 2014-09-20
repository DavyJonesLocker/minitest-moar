# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/moar/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-moar"
  spec.version       = Minitest::Moar::VERSION
  spec.authors       = ["Brian Cardarella"]
  spec.email         = ["bcardarella@gmail.com"]
  spec.summary       = %q{Moar Minitest Please!}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/dockyard/minitest-moar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.1"
end
