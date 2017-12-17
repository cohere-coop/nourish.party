require "rails_helper"

RSpec.describe ProjectRequest, type: :model do
  subject(:project_request) { create(:project_request, users: [create(:user)]) }
  describe "#approve" do
    it "creates a project with the same title, summary and users from the project request" do
      project_request.approve
      resulting_project = project_request.resulting_project
      expect(resulting_project).to be_persisted
      expect(resulting_project.title).to eq project_request.title
      expect(resulting_project.summary).to eq project_request.summary
      expect(resulting_project.users).to eq project_request.users
    end

    it "archives the project request" do
      project_request.approve
      expect(project_request).to be_archived
    end

    context "when the project request already has a resulting project" do
      before { project_request.approve }
      it "is does not create another project if the project request already has a resulting project" do
        expect { project_request.approve }.not_to change(Project, :count)
      end

      it "is returns false if the project request already has a resulting project" do
        expect(project_request.approve).to be false
      end
    end
  end
end
