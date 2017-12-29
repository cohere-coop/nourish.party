Then("I am redirected to the sign in page") do
  expect(app).to be_on(:sign_in_page)
end

Then("I should not see any errors") do
  expect(app).not_to be_showing_errors
end

Then("I am forbidden from taking that action") do
  expect(app).to be_forbidden
end
