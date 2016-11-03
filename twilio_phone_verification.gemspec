# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twilio_phone_verification/version'

Gem::Specification.new do |spec|
  spec.name          = "twilio_phone_verification"
  spec.version       = TwilioPhoneVerification::VERSION
  spec.authors       = ["vishgleb@mail.ru"]
  spec.email         = ["vishgleb@mail.ru"]

  spec.summary       = "It is simple phone verification gem using twilio.com"
  spec.description   = "twilio_phone_verification is a gem for RoR which you can use to verify users' phone numbers"
  spec.homepage      = "https://github.com/kaikash/twilio_phone_verification"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "twilio-ruby"
  spec.add_dependency "phony_rails"
  spec.add_dependency "railties"
  spec.add_dependency "activesupport"
  spec.add_dependency "activerecord"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
