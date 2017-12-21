FactoryBot.define do
  factory :project do
    title "Title #{SecureRandom.uuid}"
    summary "Summary #{SecureRandom.uuid}"
  end
end
