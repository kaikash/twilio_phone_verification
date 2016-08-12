module TwilioPhoneVerification  
  class TwilioService
    def self.send_message(message, to)
      begin
        client.messages.create(
          from: number,
          to: to,
          body: message
        )
        {success: true}
      rescue Twilio::REST::RequestError => e
        {success: false, message: e.message, code: e.code}
      end
    end

    private
    def self.client
      Twilio::REST::Client.new
    end

    def self.number
      TwilioPhoneVerification.configuration.from
    end
  end
end