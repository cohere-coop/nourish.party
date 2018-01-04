Given("an approved project connected to stripe") do
  user = create(:user)
  app.project_under_test = create(:project, members: [user])
  create(:stripe_connection, owner: user)
end

Given("a project is pending") do
  app.project_under_test = create(:project, status: :pending, members: [create(:user)])
end

Given("I had submitted a project") do
  app.project_under_test = create(:project, status: :pending, members: [app.current_user])
end

Given("I am a member of that project") do
  app.project_under_test.members << build(:registered_user) if app.project_under_test.members.none?
  app.sign_in_as(user: app.project_under_test.members.first)
end

When("I provide one off support for the project with a valid credit card") do
  app.provide_support(project: app.project_under_test)
end

When("I begin to submit a project") do
  app.visit(:new_project_page)
end

When("I submit a project") do
  title = "Title #{SecureRandom.uuid}"
  app.submit_project(title: title, summary: "Summary #{SecureRandom.uuid}")
  app.project_under_test = Project.find_by(title: title)
end

When("I reject the project") do
  app.visit(:pending_projects_page)
  current_page.reject(project: app.project_under_test)
end

When("I approve the project") do
  app.visit(:pending_projects_page)
  current_page.approve(project: app.project_under_test)
end

When("I attempt to approve the project") do
  begin
    app.visit(:pending_projects_page)
    current_page.approve(project: app.project_under_test)
  rescue NoMethodError => _
    :this_is_purposeful
  end
end

When("I attempt to reject the project") do
  begin
    app.visit(:pending_projects_page)
    current_page.reject(project: app.project_under_test)
  rescue NoMethodError => _
    :this_is_purposeful
  end
end

When(/the project receives (approval|rejection)/) do |status_change_factory|
  app.project_under_test.apply_status_change(build(status_change_factory.to_sym))
end

Then("I am a member of the project") do
  expect(app.project_under_test.members).to include(app.current_user)
end

Then("the project status changes log shows that I approved the project") do
  project_status_changes = app.current_user.project_status_changes.where(project: app.project_under_test,
                                                                         action: :approved)
  expect(project_status_changes).not_to be_empty
  app.visit(:project_status_changes_page)
  expect(current_page.project_status_changes).to be_displaying(*project_status_changes)
end

Then("the project status changes log shows that I rejected the project") do
  project_status_changes = app.current_user.project_status_changes.where(project: app.project_under_test,
                                                                         action: :rejected)
  expect(project_status_changes).not_to be_empty
  app.visit(:project_status_changes_page)
  expect(current_page.project_status_changes).to be_displaying(*project_status_changes)
end

Then("the project is publicly available") do
  expect(app).to have_public_project(project: app.project_under_test)
end

Then("the project is not publicly available") do
  expect(app).not_to have_public_project(project: app.project_under_test)
end

Then("the project is no longer pending") do
  app.visit(:pending_projects_page)
  expect(current_page.pending_projects.element_for(app.project_under_test)).not_to be_present
end

Then("the project is still pending") do
  app.project_under_test.reload
  expect(app.project_under_test).to be_pending
end

Then(/I can see the project in my projects as (approved|pending|rejected)/) do |status|
  app.visit(:my_projects_page)
  expect(app.current_page).to be_showing_project(app.project_under_test, status: status)
end

Then(/I see a notice that I (approved|rejected) the project$/) do |status|
  i18n_path = status == "approved" ? "approving_project" : "rejecting_project"
  expect(app).to be_showing_notice("#{i18n_path}.success_notification",
                                   project_title: app.project_under_test.title)
end

Then(/the project creator is sent a project (approved|rejected) email with my reason/) do |action|
  app.project_under_test.members.each do |member|
    expect(app).to have_sent_email(to_user: member,
                                   subject: I18n.t("project_status_change_mailer.#{action}.subject"),
                                   body: /#{app.project_under_test.project_status_changes.latest.reason}/)
  end
end
