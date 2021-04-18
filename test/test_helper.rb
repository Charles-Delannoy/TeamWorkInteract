ENV['RAILS_ENV'] ||= 'test'
DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # for test with devise
  include Warden::Test::Helpers
  Warden.test_mode!

  def green(text)
    puts "\e[32m#{text}\e[0m"
  end

  def green_bg(text)
    puts "\e[42m#{text}\e[0m"
  end
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome
