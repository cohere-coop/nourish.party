class Contribution
  include ActiveModel::Model

  attr_accessor :amount_in_dollars
  attr_writer :payment_processor

  def create
    payment_processor.charge(amount: amount)
  end

  def payment_processor_attributes=(params)
    params.each do |key, value|
      payment_processor.send("#{key}=", value)
    end
  end

  private def amount
    Money.new(amount_in_dollars * 100, "USD")
  end

  def payment_processor
    @payment_processor ||= StripePaymentProcessor.new
  end
end
