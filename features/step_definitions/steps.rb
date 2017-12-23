Given("I am signed in") do
  user = create(:user)
  app.login_as(user: user)
end

Given("there is already a user with the email {string}") do |email|
  User.create(email: email, password: "password")
end

Given("there is already a user with the email {string} and the password {string}") do |email, password|
  User.create(email: email, password: password)
end

When("I register with the email {string} and the password {string}") do |email, password|
  app.register_as(email: email, password: password)
end

When("I log in as {string} using the password {string}") do |email, password|
  app.login_as(email: email, password: password)
end

When("I log out") do
  app.logout
end

When("I submit a project titled {string} and summarized as {string}") do |title, summary|
  app.submit_project(title: title, summary: summary)
end

When("the project titled {string} is approved") do |title|
  project = Project.find_by(title: title)
  project.approve
end

Then("I should not see any errors") do
  expect(app).not_to be_showing_errors
end

Then("I should be logged in as {string}") do |email|
  expect(app).to be_logged_in_as(email: email)
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

Then("I should not be logged in") do
  expect(app).not_to be_logged_in
end

Then("there is not a public project titled {string} and summarized as {string}") do |title, _summary|
  expect(app).not_to have_public_project(title: title)
end

Then("I am a member of the project titled {string}") do |title|
  project = Project.find_by(title: title)
  expect(project.members).to include(app.logged_in_user)
end

Then("there is a public project titled {string} and summarized as {string}") do |title, _summary|
  expect(Project.find_by(title: title)).to be_approved
  expect(app).to have_public_project(title: title)
end
