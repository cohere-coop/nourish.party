if ENV["SMTP_ADDRESS"]
  ActionMailer::Base.smtp_settings = {
    address: ENV["SMTP_ADDRESS"],
    domain: ENV["SMTP_DOMAIN"],
    port: ENV["SMTP_PORT"].to_i,
    user_name: ENV["SMTP_USER_NAME"],
    password: ENV["SMTP_PASSWORD"],
    authentication: ENV["SMTP_AUTHENTICATION"].to_sym
  }

  ActionMailer::Base.delivery_method = :smtp
end
