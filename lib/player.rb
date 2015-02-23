class Player
  def initialize(cards=[])
    @cards = cards
  end

  def add_card(card)
    Player.new(@cards << card)
  end

  def score
    score = 0
    @cards.each do |card|
      score += card.value
    end
    score
  end

  def bust?
    score > 21
  end

  def blackjack?
    if @cards.size == 2
      first_card = @cards[0]
      second_card = @cards[1]
      if (first_card.ace? || second_card.ace?) &&
          (second_card.face? || first_card.face?)
        return true
      end
    end
    false
  end
end
