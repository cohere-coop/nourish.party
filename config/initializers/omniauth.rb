OmniAuth.config.full_host = ENV["APP_ROOT_URL"]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV["STRIPE_OAUTH_CLIENT_ID"], ENV["STRIPE_SECRET_KEY"],
           callback_path: "auth/stripe_connect/callback"
  provider :slack, ENV["SLACK_OAUTH_CLIENT_ID"], ENV["SLACK_OAUTH_CLIENT_SECRET"],
           scope: "admin,chat:write:bot,team:read,users:read,identify"
end
