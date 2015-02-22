class Player
  def initialize(cards=[])
    @cards = cards
  end

  def add_card(card)
    Player.new(@cards << card)
  end

  def score
    if blackjack?
      return :blackjack
    else
      return calculate_score
    end
  end

  private
    def blackjack?
      if @cards.size == 2
        first_card = @cards[0]
        second_card = @cards[1]
        if (first_card.value == 1 || second_card.value == 1) &&
            (second_card.face? || first_card.face?)
          return true
        end
      end
      false
    end

    def calculate_score
      score = 0
      @cards.each do |card|
        if card.face?
          score += 10
        else
          score += card.value
        end
      end
      score
    end
end
