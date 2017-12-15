require 'rails_helper'

require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'

require 'features/pages/registration_page'
require 'features/pages/login_page'
Capybara.server = :puma

module FeatureTestHelpers
  def app
    @app ||= App.new
  end
end

class App
  include Capybara::DSL


  def logged_in_as?(email)
    page.has_content?(email)
  end

  def register_with(email:, password:)
    registration_page.load
    registration_page.submit(email: email, password: password)
  end

  def login_with(email:, password:)
    login_page.load
    login_page.submit(email: email, password: password)
  end

  def registration_page
    @registration_page ||= RegistrationPage.new
  end

  def login_page
    @login_page ||= LoginPage.new
  end

  def showing_errors?
    page.has_css?(".error") || page.has_css?('#error_explanation')
  end

  def showing_error?(*translations)
    error = translations.map(&I18n.method(:t)).join(' ')
    error_text.any? { |particular_error| error.include?(error) }
  end

  def errors
    page.find_all(".error")
  end

  def error_text
    page.find_all('.error').map(&:text) + [page.find('#error_explanation').text]
  end
end
