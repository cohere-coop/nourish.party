module Nourish
  # Nourish Stripe plugin for accepting payments via stripe
  class Stripe
    def self.instance
      @instance ||= new
    end

    class << self
      attr_writer :instance
    end

    def create_charge(**kwargs)
      ::Stripe::Charge.create(**kwargs)
    end
  end
end
