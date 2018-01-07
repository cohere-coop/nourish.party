Given("stripe is accepting payments") do
end

Then("the stripe API was sent the transaction") do
  last_charge = app.stripe_api.charges.last
  expect(last_charge.amount).to eql 10_00
  expect(last_charge.currency).to eql "usd"
  expect(last_charge.source).to eql "tok_visa"
  expect(last_charge.destination_account).to eql app.project_under_test.stripe_account_id
end
