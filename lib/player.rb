class Player
  BLACKJACK = 21

  def initialize(hand=[])
    @hand = hand
  end

  def ==(target)
    score == target.score
  end

  def add_card(card)
    Player.new(@hand << card)
  end

  def score
    score = 0
    @hand.each do |card|
      score += card.value(@hand)
    end
    score
  end

  def beats?(target)
    return score > target.score
  end

  def bust?
    score > BLACKJACK
  end

  def blackjack?
    if @hand.size == 2
      return has_blackjack?
    end
    false
  end

  private
    def has_blackjack?
      first_card = @hand[0]
      second_card = @hand[1]
      (first_card.ace? || second_card.ace?) && 
        (second_card.value == 10 || first_card.value == 10)
    end
end
