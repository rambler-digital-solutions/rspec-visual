require 'singleton'

module Rspec
  module Visual
    class Configuration
      include Singleton

      class << self
        attr_accessor :screenshot_folder, :stable_screenshot_folder

        def configure
          yield self
        end

        def configure_capybara
          Capybara.register_driver :poltergeist do |app|
            Capybara::Poltergeist::Driver.new(app, js_errors: false)
          end

          RSpec.configure do |config|
            config.before(:example, :visual => :true) do
              config.include ScreenshotHelper
              Capybara.current_driver = :poltergeist
            end

            config.after(:example, :visual => :true) do
              Capybara.use_default_driver
            end
          end
        end
      end
    end
  end
end
