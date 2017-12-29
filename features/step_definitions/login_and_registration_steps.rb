Given("I am not signed in") do
  # This step definition intentionally left blank, as being not-signed in is the default
end

Given("I am signed in") do
  user = create(:user)
  app.sign_in_as(user: user)
end

Given(/^I sign in as (a|an) (user|instance admin|project creator|supporter)$/) do |_, user_type|
  user_type = user_type.tr(" ", "_").downcase.to_sym
  app.sign_in_as(user: create(user_type))
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
