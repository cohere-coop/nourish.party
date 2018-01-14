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

  describe "#stripe_connection" do
    it "is the project member's Stripe connection" do
      connection = create(:stripe_connection, owner: project.members.first)
      expect(project.stripe_connection).to eq(connection)
    end

    it "gets confused (for now) if a project has multiple members" do
      project.members << build(:registered_user)

      expect { project.stripe_connection }.to raise_error(Project::AmbiguousStripeConnection)
    end

    it "gets confused (for now) if a member has multiple Stripe connections" do
      create(:stripe_connection, owner: project.members.first)
      create(:stripe_connection, owner: project.members.first)

      expect { project.stripe_connection }.to raise_error(Project::AmbiguousStripeConnection)
    end
  end

  describe "#taking_payments?" do
    it "is true if the project is both approved and is connected to a payment processor" do
      project.apply_status_change(build(:approval))
      project.members.first.stripe_connections << build(:stripe_connection)

      expect(project).to be_taking_payments
    end

    it "is false if the project is not approved" do
      project.members.first.stripe_connections << build(:stripe_connection)

      expect(project).not_to be_taking_payments
    end

    it "is false if the project is not connected to a payment processor" do
      project.apply_status_change(build(:approval))

      expect(project).not_to be_taking_payments
    end
  end
end
