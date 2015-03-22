require_relative "card.rb"

class Ace < Card
  def initialize(suit)
    @suit = suit
    validate_suit
  end

  def ==(target)
    target.instance_of? Ace 
  end

  def value(cards=[])
    unless cards.size < 1
      score = 0
      cards.each do |card|
        score += card.value
      end
      score -= 1
      return 11 if score <= 10
    end
    1
  end

  def ace?
    true
  end
end
