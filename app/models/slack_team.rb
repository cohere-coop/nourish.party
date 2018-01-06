# Slack team supporters may be added to as a reward
class SlackTeam < ApplicationRecord
  belongs_to :owner, class_name: :RegisteredUser
end
