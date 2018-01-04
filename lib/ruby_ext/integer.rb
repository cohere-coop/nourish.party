class Integer
  def dollars
    Money.new(self * 100, "USD")
  end
end
