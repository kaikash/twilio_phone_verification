TwilioPhoneVerification.configure do |config|
  config.account_sid = ENV.fetch("TWILIO_ACCOUNT_SID") # Paste your twilio account id here
  config.auth_token = ENV.fetch("TWILIO_AUTH_TOKEN") # Paste your twilio auth token here
  config.from = ENV.fetch("TWILIO_NUMBER") # Paste your twilio number here
end