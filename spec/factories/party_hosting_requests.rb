FactoryBot.define do
  factory :party_hosting_request do
    title "Title #{SecureRandom.uuid}"
    activity "Activity #{SecureRandom.uuid}"

    trait :with_hosts do
      after(:create) do |party_hosting_request|
        party_hosting_request.hosts << create(:user)
      end
    end
  end
end
