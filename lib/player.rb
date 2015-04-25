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
    sorted_hand = @hand.sort_by {|c| c.value}
    sorted_hand.reverse.each do |card|
      score += add_card_value(card, score)
    end
    return 21 if self.blackjack?
    score
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

  def render_result(dealer)
    if (score > dealer.score or dealer.bust?) and not self.bust?
      return '<strong>You win!!</strong>'
    elsif score == dealer.score
      return 'Push...'
    end
    'Dealer wins...'
  end

  private
    def has_blackjack?
      first_card = @hand[0]
      second_card = @hand[1]
      (first_card.ace? || second_card.ace?) && 
        (second_card.value <= 10 || first_card.value <= 10)
    end

    def add_card_value(card, score_so_far)
      if card.face?
        return 10
      elsif card.ace?
        if (score_so_far + 11) <= BLACKJACK
          return 11
        end
        return 1
      end 
      return card.value
    end
end
