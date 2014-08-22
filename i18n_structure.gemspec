# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_structure/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n_structure"
  spec.version       = I18nStructure::VERSION
  spec.authors       = ["Wojciech Krysiak"]
  spec.email         = ["wojciech.g.krysiak@gmail.com"]
  spec.description   = %q{Create structure for I18n locale files}
  spec.summary       = %q{Create structure for I18n locale files}
  spec.homepage      = "https://github.com/KMPgroup/i18n-structure"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '>= 3.0.0'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'draper'
  spec.add_development_dependency 'rspec'
end
