Given("I have never provided support before") do
end

Then("I should not see any errors") do
  expect(app).not_to be_showing_errors
end

Then("I am forbidden from taking that action") do
  expect(app).to be_forbidden
end

Then("I should see a link to connect a payment processor") do
  expect(app.current_page).to have_css('a[href="/users/edit"]')
end

Then("I can see the transaction in my contributions history") do
  app.visit(:settings_page)
  expect(app.current_page.contributions).to be_displaying(*app.current_user.contributions)
end
