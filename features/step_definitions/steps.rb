Given("I am not signed in") do
  # This step definition intentionally left blank, as being not-signed in is the default
end

Given("I am signed in") do
  user = create(:user)
  app.sign_in_as(user: user)
end

Given("I am signed in as an instance admin") do
  app.sign_in_as(user: create(:instance_admin))
end

Given("a project is pending") do
  app.project_under_test = create(:project, status: :pending)
end

Given("there is already a user with the email {string}") do |email|
  User.create(email: email, password: "password")
end

Given("there is already a user with the email {string} and the password {string}") do |email, password|
  User.create(email: email, password: password)
end

When("I sign up with the email {string} and the password {string}") do |email, password|
  app.sign_up_as(email: email, password: password)
end

When("I sign in as {string} using the password {string}") do |email, password|
  app.sign_in_as(email: email, password: password)
end

When("I sign out") do
  app.sign_out
end

When("I begin to submit a project") do
  app.visit(:new_project_page)
end

When("I submit a project titled {string} and summarized as {string}") do |title, summary|
  app.submit_project(title: title, summary: summary)
end

When("I approve the project") do
  app.visit(:admin_pending_projects_page)
  current_page.approve(project: app.project_under_test)
end

When("the project titled {string} is approved") do |title|
  project = Project.find_by(title: title)
  project.approve
end

Then("I am redirected to the sign in page") do
  expect(app).to be_on(:sign_in_page)
end

Then("I should not see any errors") do
  expect(app).not_to be_showing_errors
end

Then("I should be signed in as {string}") do |email|
  expect(app).to be_signed_in_as(email: email)
end

Then("I should see an error saying that the email has been taken") do
  expect(app).to be_showing_error("activerecord.attributes.user.email", "errors.messages.taken")
end

Then("I should see an error saying that an email is required") do
  expect(app).to be_showing_error("activerecord.attributes.user.email", "errors.messages.required")
end

Then("I should see an error saying that a password is required") do
  expect(app).to be_showing_error("activerecord.attributes.user.password", "errors.messages.required")
end

Then("I should see an error saying that a password confirmation is required") do
  expect(app).to be_showing_error("activerecord.attributes.user.password_confirmation",
                                  "errors.messages.required")
end

Then("I should not be signed in") do
  expect(app).not_to be_signed_in
end

Then("there is not a public project titled {string} and summarized as {string}") do |title, _summary|
  expect(app).not_to have_public_project(title: title)
end

Then("I am a member of the project titled {string}") do |title|
  project = Project.find_by(title: title)
  expect(project.members).to include(app.current_user)
end

Then("there is a public project titled {string} and summarized as {string}") do |title, _summary|
  expect(Project.find_by(title: title)).to be_approved
  expect(app).to have_public_project(title: title)
end

Then("the moderator actions log shows that I approved the project") do
  moderator_actions = app.current_user.moderator_actions.where(moderatable: app.project_under_test,
                                                               action: :approved)
  expect(moderator_actions).not_to be_empty
  app.visit(:admin_moderator_actions_page)
  expect(current_page.moderator_actions).to be_rendering(*moderator_actions)
end

Then("the project is publicly available on the website") do
  expect(app).to have_public_project(project: app.project_under_test)
end

Then("the project is no longer available to be approved") do
  app.visit(:admin_pending_projects_page)
  expect(current_page.pending_projects.element_for(app.project_under_test)).not_to be_present
end
