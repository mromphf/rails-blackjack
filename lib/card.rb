class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def value
    return @value if @value <= 10
    10
  end
    
  def face?
    @value > 10
  end

  def ace?
    @value == 1
  end
end
