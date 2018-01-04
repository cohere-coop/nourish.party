require "rails_helper"

RSpec.describe StripePaymentProcessor, type: :model do
  describe "#charge" do
    before do
      class_double("Stripe::Charge").as_stubbed_const
      allow(Stripe::Charge).to receive(:create)
    end

    it "charges the correct credit card" do
      credit_card = FactoryBot.build(:test_credit_card, token: "tok_visa")
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor,
                                                  token: credit_card.token)

      stripe_payment_processor.charge(amount: 10.dollars)

      expect(Stripe::Charge).to have_received(:create) do |**kwargs|
        expect(kwargs[:source]).not_to be_nil
        expect(kwargs[:source]).to eq(credit_card.token)
      end
    end

    it "charges the correct amount" do
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor)

      stripe_payment_processor.charge(amount: 10.dollars)

      expect(Stripe::Charge).to have_received(:create) do |**kwargs|
        expect(kwargs[:amount]).to eq(10_00)
        expect(kwargs[:currency]).to eq("usd")
      end
    end

    it "credits the correct Stripe account" do
      stripe_connection = FactoryBot.build(:stripe_connection)
      stripe_payment_processor = FactoryBot.build(:stripe_payment_processor,
                                                  stripe_connection: stripe_connection)

      stripe_payment_processor.charge(amount: 10.dollars)

      expect(Stripe::Charge).to have_received(:create) do |**kwargs|
        expect(kwargs[:destination]).not_to be_nil
        expect(kwargs[:destination]).to eq(stripe_connection.stripe_account_id)
      end
    end
  end
end
