require_relative "home_page"
require_relative "new_project_page"
require_relative "sign_up_page"
require_relative "sign_in_page"

# Encapsulates interactions with the application for feature testing purposes. At some point this should be an
# adapter that delegates most of it's behavior to the appropriate pages, instead of manually wrapping it as it
# does now.
class App
  attr_accessor :current_user, :current_page
  include Capybara::DSL
  PAGES = {
    home_page: HomePage,
    new_project_page: NewProjectPage,
    sign_in_page: SignInPage,
    sign_up_page: SignUpPage
  }.freeze

  def on?(page)
    PAGES[page].new.all_there?
  end

  def signed_in?
    within("header") do
      !page.has_content?(I18n.t("devise.shared.links.sign_in"))
    end
  end

  def signed_in_as?(user: nil, email: nil)
    email ||= user.email
    within("header") do
      page.has_content?(email)
    end
  end

  def visit(page)
    self.current_page = PAGES[page].new
    current_page.load
  end

  def new_project_page
    @new_project_page ||= NewProjectPage.new
  end

  def submit_project(title:, summary:)
    visit(:new_project_page)
    current_page.submit(title: title, summary: summary)
  end

  def sign_up_as(email:, password:)
    visit(:sign_up_page)
    current_page.submit(email: email, password: password)
    self.current_user = User.find_by(email: email)
  end

  def sign_in_as(user: nil, email: nil, password: nil)
    email ||= user.email
    password ||= user.password
    self.current_user = user || User.find_by(email: email)
    visit(:sign_in_page)
    current_page.submit(email: email, password: password)
  end

  def sign_out
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

  def public_project?(title:)
    visit(:home_page)
    current_page.project?(title: title)
  end
  alias has_public_project? public_project?
end
