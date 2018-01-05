require "dotenv"
Dotenv.load(".env.test")
require_relative "../../spec/support/simplecov"
require "capybara/rails"
require "capybara/rspec"
require "selenium-webdriver"
require "site_prism"

require "pages/app"

Capybara.server = :puma

# Mixin for feature tests so they can interact with the application instead of using capybara
module FeatureTestHelpers
  def app
    @app ||= App.new
  end

  def current_page
    app.current_page
  end
end

World(FeatureTestHelpers)
World(FactoryBot::Syntax::Methods)
