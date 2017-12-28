FactoryBot.define do
  factory :user do
    email "user-#{SecureRandom.uuid}@example.com"
    password "password"

    factory :instance_admin do
      instance_admin true
    end
  end
end
