FactoryBot.define do
  factory :slack_team do
    name { "Slack Team #{SecureRandom.uuid}" }
    owner factory: :user
  end
end
