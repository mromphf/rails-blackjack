require_relative "card.rb"

class Ace < Card
  attr_reader :value

  def initialize(suit)
    @value = 1
    @suit = suit
    validate_suit
  end

  def to_s
    "Ace of #{SUIT_STRINGS[@suit]}"
  end

  def ==(target)
    (@suit == target.suit) && (target.instance_of? Ace)
  end

  def ace?
    true
  end
  
  def face?
    false
  end

  def state
    { value: 1, suit: SUIT_STRINGS[@suit] }
  end

  def render
    suit = SUIT_STRINGS[@suit].downcase
    "#{suit}01.png"
  end
end
