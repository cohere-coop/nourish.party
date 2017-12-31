# Mailer used to test that emails actually go out
class TestMailer < ApplicationMailer
  def test_email(address:)
    mail(to: address, subject: "Nourish can send emails!")
  end
end
