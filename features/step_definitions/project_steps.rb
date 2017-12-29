Given("a project is pending") do
  app.project_under_test = create(:project, status: :pending)
end

When("I begin to submit a project") do
  app.visit(:new_project_page)
end

When("I submit a project titled {string} and summarized as {string}") do |title, summary|
  app.submit_project(title: title, summary: summary)
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

When("the project titled {string} is approved") do |title|
  project = Project.find_by(title: title)
  project.approve
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

Then("the project status changes log shows that I approved the project") do
  project_status_changes = app.current_user.project_status_changes.where(project: app.project_under_test,
                                                                         action: :approved)
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

Then("the project is no longer available to be approved") do
  app.visit(:pending_projects_page)
  expect(current_page.pending_projects.element_for(app.project_under_test)).not_to be_present
end

Then("the project is still pending approval") do
  app.project_under_test.reload
  expect(app.project_under_test).to be_pending
end
