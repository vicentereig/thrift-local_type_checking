# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thrift/local_type_checking/version'

Gem::Specification.new do |spec|
  spec.name          = 'thrift-local_type_checking'
  spec.version       = Thrift::LocalTypeChecking::VERSION
  spec.authors       = ['Vicente Reig Rincón de Arellano']
  spec.email         = ['vicente.reig@gmail.com']
  spec.summary       = %q{Enables Type Checking per client}
  spec.description   = %q{Enables Type Checking per client}
  spec.homepage      = 'https:://github.com/vicentereig/thrift-local_type_checking'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'
  spec.add_dependency 'thrift'

end
