# Processes charges through the Stripe API
class StripePaymentProcessor
  extend ActiveModel::Model

  attr_accessor :token,
                :stripe_connection

  # @see https://stripe.com/docs/connect/direct-charges
  def charge(amount:)
    stripe.create_charge({ source: token, amount: amount.cents,
                           currency: amount.currency.iso_code.downcase },
                         stripe_account: stripe_connection.stripe_account_id)
  end

  def persisted?
    false
  end

  private def stripe
    Nourish::Stripe.instance
  end
end
