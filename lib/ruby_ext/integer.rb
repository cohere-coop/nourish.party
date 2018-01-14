# Allows integers to be cast to dollars
class Integer
  def dollars
    Money.new(self * 100, "USD")
  end
end
