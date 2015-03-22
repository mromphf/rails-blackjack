require_relative "card.rb"

class Ace < Card
  def initialize(suit)
    @suit = suit
  end

  def value(cards=[])
    1
  end
end
