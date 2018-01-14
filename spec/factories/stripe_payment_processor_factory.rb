FactoryBot.define do
  factory :stripe_payment_processor do
    token "tok_visa"
    association :stripe_connection, strategy: :build
  end
end
