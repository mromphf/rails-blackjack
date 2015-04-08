require_relative "card.rb"

class Ace < Card
  def initialize(suit)
    @suit = suit
    validate_suit
  end

  def to_s
    "Ace of #{SUIT_STRINGS[@suit]}"
  end

  def ==(target)
    (@suit == target.suit) && (target.instance_of? Ace)
  end

  def value(cards=[])
    unless cards.empty?
      score = 0
      aces_in_hand = 0
      cards.each do |card|
        score += card.value
        aces_in_hand += 1 if card.ace?
      end
      if (score <= 11) and (score + 11 >= 21) and aces_in_hand < 2
         return 11 
      end
    end
    1
  end

  def ace?
    true
  end

  def state
    { value: 1, suit: SUIT_STRINGS[@suit] }
  end

  def render
    suit = SUIT_STRINGS[@suit].downcase
    "#{suit}01.png"
  end
end
