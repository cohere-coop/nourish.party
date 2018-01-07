module Nourish
  # Nourish Stripe plugin for accepting payments via stripe
  class Stripe
    def self.instance
      @instance ||= new
    end

    class << self
      attr_writer :instance
    end

    def create_charge(*args, **kwargs)
      ::Stripe::Charge.create(*args, **kwargs)
    end
  end
end
