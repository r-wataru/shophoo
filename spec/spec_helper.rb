$VERBOSE = nil

require 'rubygems'
require 'simplecov'
require 'database_cleaner'

SimpleCov.start do
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Libraries', 'app/channels'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
end

ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/rails/mocha'

DatabaseCleaner.strategy = :truncation
Capybara.javascript_driver = :webkit

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

TimeZero = Time.utc(2013)

RSpec.configure do |config|
  config.mock_with :mocha
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before(:suite) do
    DatabaseCleaner.clean
  end
  config.before(:all) do
    ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  end
  config.before(:each) do
    Capybara.current_session.driver.header('Accept-Language', 'ja')

    if self.class.metadata[:js]
      Timecop.travel(TimeZero)
    else
      Timecop.freeze(TimeZero)
    end
  end
end
