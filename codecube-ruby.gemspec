# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codecube/version'

Gem::Specification.new do |spec|
  spec.name          = "codecube"
  spec.version       = Codecube::VERSION
  spec.authors       = ["Harry Marr"]
  spec.email         = ["harry.marr@gmail.com"]
  spec.summary       = %q{Ruby client library for codecube.io}
  spec.homepage      = "http://codecube.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", "~> 0.6.9"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "webmock", "~> 1.18.0"
  spec.add_development_dependency "vcr", "~> 2.9.2"
end
