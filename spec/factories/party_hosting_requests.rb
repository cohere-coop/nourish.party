FactoryBot.define do
  factory :party_hosting_request do
    title "Title #{SecureRandom.uuid}"
    summary "Summary #{SecureRandom.uuid}"
  end
end
