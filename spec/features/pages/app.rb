require 'features/pages/home_page'
require 'features/pages/new_party_hosting_request_page'
require 'features/pages/registration_page'
require 'features/pages/login_page'

class App
  include Capybara::DSL

  def logged_in?
    within("header") do
      !page.has_content?(I18n.t("devise.shared.links.sign_in"))
    end
  end

  def logged_in_as?(user: nil, email: user&.email, password: user&.password)
    within("header") do
      page.has_content?(email)
    end
  end

  def new_party_hosting_request_page
    @new_party_hosting_request_page ||= NewPartyHostingRequestPage.new
  end

  def submit_party_hosting_request(title:, activity:)
    new_party_hosting_request_page.load
    new_party_hosting_request_page.submit(title: title, activity: activity)
  end

  def registration_page
    @registration_page ||= RegistrationPage.new
  end

  def register_as(email:, password:)
    registration_page.load
    registration_page.submit(email: email, password: password)
  end

  def login_page
    @login_page ||= LoginPage.new
  end

  def login_as(user: nil, email: user&.email, password: user&.password)
    login_page.load
    login_page.submit(email: email, password: password)
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

  def home_page
    @home_page ||= HomePage.new
  end

  def has_public_party?(title:)
    home_page.load
    home_page.has_party?(title: title)
  end
end
