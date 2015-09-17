# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/visual/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-visual"
  spec.version       = Rspec::Visual::VERSION
  spec.authors       = ["Simon Bagreev"]
  spec.email         = ["sbagreev@gmail.com"]
  spec.summary       = %Q{ Visual testing with rspec via screenshot comparison. }
  spec.description   = %Q{ Adds 'visual' specs and matchers that take screenshots
                          of the app and compare them to find regressions in
                          frontend. Must have imagemagick installed! Depends on
                          rspec, capybara, poltergeist }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "capybara", "~> 2.4"
  spec.add_dependency "poltergeist", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
