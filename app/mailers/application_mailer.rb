# Base mailer for all app mailers to ensure they have the standard settings
class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_DEFAULT_FROM"]
  layout "mailer"
end
