# Contributions made by a supporter to a project
class Contribution < ApplicationRecord
  attr_reader :amount_in_dollars
  attr_writer :payment_processor
  attr_accessor :charge

  belongs_to :project
  delegate :title, to: :project, prefix: true
  delegate :statement_descriptor, to: :project

  belongs_to :contributor, class_name: :RegisteredUser

  attribute :amount_cents, :integer

  def process
    transaction do
      save
      return false unless persisted?
      self.charge = payment_processor.charge(amount: amount)
      self.amount_cents = charge.amount
      charge.captured?
    end
  end

  def amount_in_dollars=(amount_in_dollars)
    (self.amount_cents = amount_in_dollars.to_f * 100) && return if amount_in_dollars.respond_to?(:to_f)
    raise ArgumentError, "amount_in_dollars must respond to #to_f, but is a #{amount_in_dollars.class}"
  end

  def payment_processor_attributes=(params)
    params.each do |key, value|
      payment_processor.send("#{key}=", value)
    end
  end

  def amount
    Money.new(amount_cents, "USD")
  end

  def payment_processor
    @payment_processor ||= StripePaymentProcessor.new
  end
end
