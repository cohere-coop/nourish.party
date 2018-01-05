# Helper for making assertions against a particular email from ActionMailer::Deliveries
class TestEmail
  attr_accessor :email
  def initialize(email)
    self.email = email
  end

  def matches?(subject:, body: //)
    email.subject == subject &&
      body.match?(email.text_part.body.to_s) &&
      body.match?(email.html_part.body.to_s)
  end
end
