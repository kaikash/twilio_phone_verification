require "rails/generators/base"
module TwilioPhoneVerification
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      argument :user_class, type: :string, default: "User"

      def copy_initializer
        copy_file 'twilio_phone_verification.rb', 'config/initializers/twilio_phone_verification.rb'
      end

      def copy_migrations
        if self.class.migration_exists?("db/migrate", "add_phone_to_#{ user_class.underscore }")
          say_status("skipped", "Migration 'add_phone_to_#{ user_class.underscore }' already exists")
        else
          migration_template(
            "add_phone_to_users.rb.erb",
            "db/migrate/add_phone_to_#{ user_class.underscore }.rb"
          )
        end
      end
    end
  end
end