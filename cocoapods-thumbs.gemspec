# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-thumbs/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-thumbs"
  spec.version       = CocoapodsThumbs::VERSION
  spec.authors       = ["Pablo Bendersky"]
  spec.summary       = %q{CocoaPods plugin which allows to see peer votes of a Podfile or single Podspec.}
  spec.homepage      = "https://github.com/quadion/cocoapods-thumbs"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
