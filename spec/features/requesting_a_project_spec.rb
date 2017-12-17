require "features/helper"

describe "Requesting a project" do
  include FeatureTestHelpers
  it "requires the project to be approved before it becomes visible" do
    user = create(:user)
    app.login_as(user: user)
    app.submit_project_request(title: "Robotic Pidgeons",
                               summary: "We're designing robotic pigeons and letting them loose")

    expect(app).not_to have_public_project(title: "Robotic Pidgeons")

    project_request = ProjectRequest.find_by(title: "Robotic Pidgeons")
    expect(project_request.users).to include(user)
    project_request.approve
    expect(project_request.resulting_project).to be_persisted
    expect(project_request.resulting_project.users).to include(user)

    expect(app).to have_public_project(title: "Robotic Pidgeons")
  end
end
