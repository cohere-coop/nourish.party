OmniAuth.config.full_host = ENV["APP_ROOT_URL"]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV["STRIPE_OAUTH_CLIENT_ID"], ENV["STRIPE_SECRET_KEY"],
           callback_path: "/auth/stripe_connect/callback"
end
