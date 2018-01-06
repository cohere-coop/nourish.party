module Nourish
  # Nourish plugin for slack features, currently a feature flag. Maybe more someday.
  class Slack
    def self.enabled?
      ENV["SLACK_OAUTH_CLIENT_ID"].present? && ENV["SLACK_OAUTH_CLIENT_SECRET"].present?
    end
  end
end
