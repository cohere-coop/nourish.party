require "features/helper"

describe "ing a project" do
  include FeatureTestHelpers
  it "requires the project to be approved before it becomes visible" do
    user = create(:user)
    app.login_as(user: user)
    app.submit_project(title: "Robotic Pidgeons",
                       summary: "We're designing robotic pigeons and letting them loose")

    expect(app).not_to have_public_project(title: "Robotic Pidgeons")

    project = Project.find_by(title: "Robotic Pidgeons")
    expect(project.members).to include(user)

    project.approve

    expect(project).to be_approved
    expect(app).to have_public_project(title: "Robotic Pidgeons")
  end
end
