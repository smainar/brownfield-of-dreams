require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_API_KEY>") { ENV['GITHUB_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_CLIENT_ID>") { ENV['GITHUB_CLIENT_ID'] }
  config.filter_sensitive_data("<GITHUB_CLIENT_SECRET>") { ENV['GITHUB_CLIENT_SECRET'] }
end


ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def test_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: 'github',
        uid: ENV['GITHUB_CLIENT_ID'],
        info: {
          nickname: 'MillsProvosty',
          urls: {
            GitHub: 'https://github.com/MillsProvosty'
          }
        },
        credentials: {
          token: ENV['GITHUB_API_KEY'],
        }
      )
  end
