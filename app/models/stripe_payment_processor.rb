class StripePaymentProcessor
  extend ActiveModel::Model

  attr_accessor :token,
                :stripe_connection

  def charge(amount:)
    Stripe::Charge.create(source: token,
                          amount: amount.cents,
                          currency: amount.currency.iso_code.downcase,
                          destination: stripe_connection.stripe_account_id)
  end

  def persisted?
    false
  end
end
