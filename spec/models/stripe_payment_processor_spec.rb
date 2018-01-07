require "rails_helper"

RSpec.describe StripePaymentProcessor, type: :model do
  describe "#charge" do
    it "charges the correct credit card" do
      credit_card = FactoryBot.build(:test_credit_card, token: "tok_visa")
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor,
                                                  token: credit_card.token)

      charge = stripe_payment_processor.charge(amount: 10.dollars)
      expect(charge.source).to be_present
      expect(charge.source).to eq(credit_card.token)
    end

    it "charges the correct amount" do
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor)

      charge = stripe_payment_processor.charge(amount: 10.dollars)

      expect(charge.amount).to eq(10_00)
      expect(charge.currency).to eq("usd")
    end

    it "credits the correct Stripe account" do
      stripe_connection = FactoryBot.build(:stripe_connection)
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor,
                                                  stripe_connection: stripe_connection)

      charge = stripe_payment_processor.charge(amount: 10.dollars)

      expect(charge.destination_account).to be_present
      expect(charge.destination_account).to eq(stripe_connection.stripe_account_id)
    end
  end
end
