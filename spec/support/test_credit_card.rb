# Convenience for test credit cards.
#
# Replace implementation with a keyword_init: true struct when Ruby 2.5 hits.
TestCreditCard = Struct.new(:number, :expiration_month, :expiration_year, :security_code, :token) do
  def initialize(number:, expiration_month:, expiration_year:, security_code:, token:)
    self.number = number
    self.expiration_month = expiration_month
    self.expiration_year = expiration_year
    self.security_code = security_code
    self.token = token
  end
end
