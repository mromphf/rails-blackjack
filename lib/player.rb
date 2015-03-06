class Player
  def initialize(hand=[])
    @hand = hand
  end

  def add_card(card)
    Player.new(@hand << card)
  end

  def score
    score = 0
    @hand.each do |card|
      score += card.value
    end
    score
  end

  def bust?
    score > 21
  end

  def blackjack?
    if @hand.size == 2
      return blackjack_logic(@hand[0], @hand[1])
    end
    false
  end

  private
    def blackjack_logic(first_card, second_card)
      (first_card.ace? || second_card.ace?) && 
        (second_card.face? || first_card.face?)
    end
end
