require "rails_helper"

RSpec.describe Contribution, type: :model do
  describe "#create" do
    it "charges the payment processor the correct amount" do
      payment_processor = instance_double("StripePaymentProcessor")
      contribution = Contribution.new(
        payment_processor: payment_processor,
        amount_in_dollars: 10
      )
      allow(payment_processor).to receive(:charge)

      contribution.create

      expect(payment_processor).to have_received(:charge) do |**kwargs|
        expect(kwargs[:amount]).to eq(10.dollars)
      end
    end
  end
end
