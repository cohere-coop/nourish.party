Given("stripe is accepting payments") do
end

Then("a stripe customer was created for me") do
  # I'm not actually sure that this needs to be a database field
  # How do you expect to use it?
  expect(app.current_user.stripe_customer_id).not_to be_nil
  expect(app.stripe_api.created_customers.last).to include(tok: "fake-elements-token",
                                                           email: app.current_user.email_address,
                                                           description: "id: #{app.current_user.id}")
end

Then("the stripe API was sent the transaction") do
  expect(app.stripe_api.created_charges.last).to include(amount: 10_00,
                                                         currency: "usd",
                                                         customer: app.current_user.stripe_customer_id,
                                                         stripe_account:
                                                           app.project_under_test.stripe_account_id)
end
