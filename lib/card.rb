class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def ==(card)
    @value == card.state[0] && @suit == card.state[1]
  end

  def state
    [@value, @suit]
  end
end
