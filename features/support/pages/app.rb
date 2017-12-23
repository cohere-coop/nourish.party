require "pages/home_page"
require "pages/new_project_page"
require "pages/registration_page"
require "pages/login_page"

# Encapsulates interactions with the application for feature testing purposes. At some point this should be an
# adapter that delegates most of it's behavior to the appropriate pages, instead of manually wrapping it as it
# does now.
class App
  attr_accessor :logged_in_user
  include Capybara::DSL

  def logged_in?
    within("header") do
      !page.has_content?(I18n.t("devise.shared.links.sign_in"))
    end
  end

  def logged_in_as?(user: nil, email: nil)
    email ||= user.email

    within("header") do
      page.has_content?(email)
    end
  end

  def new_project_page
    @new_project_page ||= NewProjectPage.new
  end

  def submit_project(title:, summary:)
    new_project_page.load
    new_project_page.submit(title: title, summary: summary)
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

  def login_as(user: nil, email: nil, password: nil)
    email ||= user.email
    password ||= user.password
    self.logged_in_user = user || User.find_by(email: email)
    login_page.load
    login_page.submit(email: email, password: password)
  end

  def logout
    page.click_on(I18n.t("devise.shared.links.sign_out"))
  end

  def showing_errors?
    page.has_css?(".error") || page.has_css?("#error_explanation")
  end

  def showing_error?(*translations)
    error = translations.map(&I18n.method(:t)).join(" ")
    error_text.any? { |_particular_error| error.include?(error) }
  end

  def errors
    page.find_all(".error")
  end

  def error_text
    page.find_all(".error").map(&:text) + [page.find("#error_explanation").text]
  end

  def home_page
    @home_page ||= HomePage.new
  end

  def public_project?(title:)
    home_page.load
    home_page.project?(title: title)
  end
  alias has_public_project? public_project?
end
