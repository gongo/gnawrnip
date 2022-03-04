# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gnawrnip/version'

Gem::Specification.new do |spec|
  spec.name          = "gnawrnip"
  spec.version       = Gnawrnip::VERSION
  spec.authors       = ["Wataru MIYAGUNI"]
  spec.email         = ["gonngo@gmail.com"]
  spec.description   = %q{Gnawrnip is a TurnipFormatter Add-on that provides put a screen shot to report use Capybara}
  spec.summary       = %q{Add-on for TurnipFormatter with Capybara}
  spec.homepage      = "https://github.com/gongo/gnawrnip"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'capybara', "~> 3"
  spec.add_dependency 'turnip_formatter', '~> 0.7.0'
  spec.add_dependency 'oily_png'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'
end
