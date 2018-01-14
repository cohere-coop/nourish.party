module Nourish
  # Nourish Stripe plugin for accepting payments via stripe
  class Stripe
    def create_charge(*args, **kwargs)
      ::Stripe::Charge.create(*args, **kwargs)
    end

    class << self
      attr_writer :instance
      def instance
        @instance ||= new
      end
    end
  end
end
