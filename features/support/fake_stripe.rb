# Adapter to sit between the app and stripe for testing purposes
class FakeStripe
  def create_charge(stripe_charge, options)
    charge = FakeCharge.new(stripe_charge, options)
    charges.push(charge)
    charge
  end

  def charges
    @charges ||= []
  end

  # Wraps chages for expectation matching purposes
  class FakeCharge
    attr_accessor :stripe_charge, :options
    def initialize(stripe_charge, options)
      self.stripe_charge = stripe_charge
      self.options = options
    end

    def amount
      stripe_charge[:amount]
    end

    def source
      stripe_charge[:source]
    end

    def currency
      stripe_charge[:currency]
    end

    def destination_account
      options[:stripe_account]
    end

    def captured?
      true
    end

    def paid?
      true
    end
  end
end
