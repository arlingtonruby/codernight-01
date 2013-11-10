# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'international_trade/version'

Gem::Specification.new do |spec|
  spec.name          = "international_trade"
  spec.version       = InternationalTrade::VERSION
  spec.authors       = ["Chris Hoffman"]
  spec.email         = ["yarmiganosca@gmail.com"]
  spec.description   = "A purposefully over-engineered solution to Puzzlenode #1"
  spec.summary       = "A solution to Puzzlenode #1"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "nokogiri"
end
