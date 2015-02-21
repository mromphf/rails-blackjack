class Player
  def initialize(cards=[])
    @cards = cards
  end

  def add_card(card)
    Player.new(@cards << card)
  end

  def score
    score = 0
    return :blackjack if blackjack?(@cards)
    @cards.each do |card|
      score += card.value
    end
    score
  end

  private
    def blackjack?(cards)
      result = false
      if cards.size == 2
        first_card = cards[0]
        second_card = cards[1]
        if (first_card.value == 1 || second_card.value == 1) &&
            (second_card.face? || first_card.face?)
          return true
        end
      end
      result 
    end
end
