Given("an approved project that does not have any valid payment processor connections exists") do
  app.project_under_test = create(:project)
  app.project_under_test.apply_status_change(build(:approval))
end

Given("an approved project with valid payment processor connections exists") do
  app.project_under_test = create(:project)
  app.project_under_test.apply_status_change(build(:approval))
  app.project_under_test.members << build(:registered_user) if app.project_under_test.members.none?
  app.project_under_test.members.first.stripe_connections << build(:stripe_connection)
end

Given("I am a potential contributor to that project") do
end

When("I visit that project's contribution page") do
  app.visit(:new_project_contribution_page, project_id: app.project_under_test.id)
end

Then("I should see a message telling me that the project is not ready to accept contributions") do
  expect(app.current_page.not_ready_yet_message).to be_present
end

Then("I should be able to contribute to that project") do
  expect(app.current_page.ready_for_contributions_message).to be_present
end
