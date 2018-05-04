ENV["RACK_ENV"] = "test"

require 'bundler'
Bundler.require(:default, :test)
require File.expand_path("../../config/environment.rb", __FILE__)
# require 'rspec'
require 'capybara/dsl'

Capybara.app = LittleShopApp
Capybara.save_path = 'tmp'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.app = LittleShopApp

RSpec.configure do |c|
  c.include Capybara::DSL
end
