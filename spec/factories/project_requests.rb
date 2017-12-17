FactoryBot.define do
  factory :project_request do
    title "Title #{SecureRandom.uuid}"
    summary "Summary #{SecureRandom.uuid}"
  end
end
