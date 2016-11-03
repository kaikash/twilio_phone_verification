module TwilioPhoneVerification::Phonable
  extend ActiveSupport::Concern

  included do
    before_save :change_phone_confirmed_at, if: :phone_changed?
    phony_normalize :phone
    validates :phone, phony_plausible: true, presence: true, uniqueness: true
  end

  def phone_confirmed?
    !!phone_confirmed_at
  end

  def change_phone_confirmed_at
    self.phone_confirmed_at = nil
  end

  def send_phone_confirmation
    if phone_confirmed?
      errors.add(:phone, "has already been confirmed.")
      return false
    end
    if !phone_confirmation_sent_at || Time.now - phone_confirmation_sent_at > phone_confirmation_delay
      generate_phone_confirmation_token
      twilio_res = TwilioPhoneVerification::TwilioService.send_message(phone_confirmation_message, phone)
      unless twilio_res[:success]
        errors.add(:phone, "Error occured, while sending code. Please try again later.")
        return false
      end
      twilio_res
    else
      errors.add(:code, "can be sent once per #{phone_confirmation_delay.to_s} seconds.")
      return false
    end
  end

  def confirm_phone_by_code(code)
    if ActiveSupport::SecurityUtils.secure_compare phone_confirmation_token, code
      return confirm_phone
    else
      errors.add(:code, " is wrong, try again.")
      return false
    end
  end

  def confirm_phone
    if phone_confirmed?
      errors.add(:phone, "has already been confirmed.")
      return false
    end
    self.phone_confirmed_at = Time.now
    save
  end

  def generate_phone_confirmation_token
    self.phone_confirmation_token = get_phone_confirmation_token
    self.phone_confirmation_sent_at = Time.now
    save
  end

  private
  def phone_confirmation_delay
    1.minute
  end

  def get_phone_confirmation_token
    (0..9).to_a.shuffle[0,6].join
  end

  def phone_confirmation_message
    return false unless phone_confirmation_token
    "Hello, #{name}. Your verification code: #{phone_confirmation_token}"
  end
end