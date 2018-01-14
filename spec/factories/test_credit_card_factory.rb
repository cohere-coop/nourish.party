require "faker"

FactoryBot.define do
  factory :test_credit_card do
    number { Faker::Stripe.valid_card }
    expiration_month { Faker::Stripe.month }
    expiration_year { Faker::Stripe.year }
    security_code { Faker::Stripe.ccv }
    token "tok_visa"

    initialize_with do
      TestCreditCard.new(**attributes)
    end
  end
end
