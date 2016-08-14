require "active_support/all"
require "twilio_phone_verification/version"
require "twilio_phone_verification/phonable"
require "twilio_phone_verification/twilio_service"
require "twilio_phone_verification/configuration"
require "twilio-ruby"
require "phony_rails"

module TwilioPhoneVerification
  def self.configure(&block)
    yield configuration
    raise "Configuration error" unless configuration.account_sid && configuration.auth_token && configuration.from
    Twilio.configure do |config|
      config.account_sid = configuration.account_sid
      config.auth_token = configuration.auth_token
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
