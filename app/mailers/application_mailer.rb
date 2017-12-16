# Base mailer for all app mailers to ensure they have the standard settings
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
