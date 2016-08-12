# TwilioPhoneVerification

`twilio_phone_verification` is a gem for Ruby on Rails applications which you can use to verify user's phone numbers using twilio.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem "twilio_phone_verification"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twilio_phone_verification

## Configuration

First of all you need to install config files. You can to it using this command:

```bash
rails g twilio_phone_verification:install [USER_CLASS]
```

### Example

```bash
rails g twilio_phone_verification:install User
```

It wil generate two files `config/initializers/twilio_phone_verification.rb` and `add_phone_to_users` migration. You will have to set your secret keys in initializer file or put it in `.env` file.

```ruby
TwilioPhoneVerification.configure do |config|
  config.account_sid = ENV.fetch("TWILIO_ACCOUNT_SID") # Paste your twilio account id here
  config.auth_token = ENV.fetch("TWILIO_AUTH_TOKEN") # Paste your twilio auth token here
  config.from = ENV.fetch("TWILIO_NUMBER") # Paste your twilio number here
end
```

After this you will need to add concern to your `model`

```ruby
class User < ActiveRecord::Base
  include TwilioPhoneVerification::Phonable
end
```

That's it! 

## Usage

Now you can call some new methods on your model

| Method | Description |
|---|---|
| **`phone_confirmed?`** | Returns `true` if phone was confirmed, or `false` if it wasn't. |
| **`send_phone_confirmation`** | Generate and send generated code to user's phone number. Returns `{success: true}` if code was sent, or `false` if it wasn't |
| **`confirm_phone_by_code(code)`** | Returns `true` and makes user's phone verified if code was correct, otherwise `false`. |
| **`confirm_phone`** | Confirms user's phone number without sending a code |

If one of these methods returns `false`, you can see error in `.errors` method. (except `phone_confirmed?`)

**Note:** Code can be sent only once per 60 seconds, if you call `send_phone_confirmation` few times, it will send only one code.

**Note:** No need to validate `phone`. It validates `phone` out of the box :)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaikash/twilio_phone_verification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

