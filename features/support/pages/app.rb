require_relative "element_collection"

require_relative "project_status_change_form_section"
require_relative "project_status_change_section"
require_relative "pending_project_section"
require_relative "slack_team_section"

require_relative "home_page"
require_relative "my_projects_page"
require_relative "new_project_page"
require_relative "pending_projects_page"
require_relative "project_status_changes_page"
require_relative "settings_page"
require_relative "sign_up_page"
require_relative "sign_in_page"
require_relative "new_project_contribution_page"

# Encapsulates interactions with the application for feature testing purposes. At some point this should be an
# adapter that delegates most of it's behavior to the appropriate pages, instead of manually wrapping it as it
# does now.
class App
  include Capybara::DSL

  attr_accessor :current_user, :current_page, :project_under_test

  PAGES = {
    home_page: HomePage,
    my_projects_page: MyProjectsPage,
    new_project_page: NewProjectPage,
    project_status_changes_page: ProjectStatusChangesPage,
    pending_projects_page: PendingProjectsPage,
    settings_page: SettingsPage,
    sign_in_page: SignInPage,
    sign_up_page: SignUpPage,
    new_project_contribution_page: NewProjectContributionPage
  }.freeze

  def on?(page)
    PAGES[page].new.all_there?
  end

  def forbidden?
    page.status_code == 403
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

  def visit(page, params = {})
    self.current_page = PAGES[page].new
    current_page.load(params)
  end

  def provide_support(project:, amount: 10.dollars, credit_card: FactoryBot.build(:test_credit_card))
    visit(:new_project_contribution_page, project_id: project.id)
    current_page.make_one_off_contribution(credit_card: credit_card, amount: amount)
  end

  def approve_project(project:)
    visit(:admin_pending_projects_page)
    current_page.approve(project: project)
  end

  def submit_project(title:, summary:)
    visit(:new_project_page)
    current_page.submit(title: title, summary: summary)
  end

  def sign_up_as(email:, password:)
    visit(:sign_up_page)
    current_page.submit(email: email, password: password)
    self.current_user = RegisteredUser.find_by(email: email)
  end

  def sign_in_as(user: nil, email: nil, password: nil)
    email ||= user.email
    password ||= user.password
    self.current_user = user || RegisteredUser.find_by(email: email)
    visit(:sign_in_page)
    current_page.submit(email: email, password: password)
  end

  def sign_out
    page.click_on(I18n.t("devise.shared.links.sign_out"))
  end

  def showing_notice?(translation, interpolations = {})
    page.find('.notification.\--notice').has_text?(I18n.t(translation, interpolations))
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

  def public_project?(project: nil, title: nil)
    title ||= project.title
    visit(:home_page)
    current_page.project?(title: title)
  end
  alias has_public_project? public_project?

  def emails_to(address)
    ActionMailer::Base.deliveries.select do |email|
      email.to.include?(address)
    end.map(&TestEmail.method(:new))
  end

  def sent_email?(to_user:, subject:, body: //)
    emails_to(to_user.email).any? do |email|
      email.matches?(subject: subject, body: body)
    end
  end
  alias has_sent_email? sent_email?

  def stripe_api
    Nourish::Stripe.instance
  end
end
