# Adapter to sit between the app and stripe for testing purposes
class FakeStripe
  def create_charge(**kwargs)
    charges << kwargs
  end

  def charges
    @charges ||= []
  end
end
