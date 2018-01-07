require "rails_helper"

RSpec.describe Contribution, type: :model do
  describe "#process" do
    it "charges the payment processor the correct amount" do
      Nourish::Stripe.instance = FakeStripe.new
      project_creator = create(:user)
      connection = create(:stripe_connection, owner: project_creator)
      contribution = Contribution.new(
        payment_processor_attributes: { token: "not-real", stripe_connection: connection },
        amount_in_dollars: 10, project: create(:project, members: [project_creator]),
        contributor: create(:user)
      )

      contribution.process
      charge = contribution.charge
      expect(charge.amount).to be(10_00)
      expect(charge.currency).to eql("usd")
    end
  end
end
