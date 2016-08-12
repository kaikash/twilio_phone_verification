module Rails
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root(File.expand_path(File.dirname(__FILE__))
      def copy_initializer
        copy_file 'twilio_phone_verification.rb', 'config/initializers/twilio_phone_verifications.rb'
      end
    end
  end
end