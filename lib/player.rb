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
      if card.face?
        score += 10
      elsif card.ace?
        if (score + 11) <= BLACKJACK
          score += 11
        else
          score += 1
        end
      else
        score += card.value
      end
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
end
