FactoryBot.define do
  factory :registered_user do
    email "user-#{SecureRandom.uuid}@example.com"
    password "password"

    factory :instance_admin do
      instance_admin true
    end

    factory :user do
    end
  end
end
