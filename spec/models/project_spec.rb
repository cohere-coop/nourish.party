require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { create(:project, members: [create(:registered_user)]) }

  it "starts pending" do
    expect(project).to be_pending
  end

  describe "#apply_status_change" do
    it "updates the project status to approved when given an approval" do
      project.apply_status_change(build(:approval))
      expect(project).to be_approved
    end

    it "updates the project status to rejected when given a rejection" do
      project.apply_status_change(build(:rejection))
      expect(project).to be_rejected
    end
  end
end
