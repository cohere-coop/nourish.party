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

Then("I should not see any errors") do
  expect(app).not_to be_showing_errors
end

Then("I should be logged in as {string}") do |email|
  expect(app).to be_logged_in_as(email)
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
