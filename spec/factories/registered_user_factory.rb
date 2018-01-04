FactoryBot.define do
  factory :registered_user, aliases: [:user] do
    email { "user-#{SecureRandom.uuid}@example.com" }
    password "password"

    factory :instance_admin do
      email { "instance-admin-#{SecureRandom.uuid}@example.com" }
      instance_admin true
    end
  end
end
