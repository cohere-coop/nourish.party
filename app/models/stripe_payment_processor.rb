# Processes charges through the Stripe API
class StripePaymentProcessor
  extend ActiveModel::Model

  attr_accessor :token,
                :stripe_connection

  def charge(amount:)
    stripe.create_charge(source: token,
                         amount: amount.cents,
                         currency: amount.currency.iso_code.downcase,
                         destination: { account: stripe_connection.stripe_account_id })
  end

  def persisted?
    false
  end

  private def stripe
    Nourish::Stripe.instance
  end
end
