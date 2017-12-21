FactoryBot.define do
  factory :user do
    email "user-#{SecureRandom.uuid}@example.com"
    password "password"
  end
end
