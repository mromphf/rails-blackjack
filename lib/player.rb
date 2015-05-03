require_relative "player_wins"

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
    return BLACKJACK if self.blackjack?
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

  def determine_result(dealer)
    if (self.score > dealer.score and not self.bust?) or dealer.bust?
      return PlayerWins.new
    elsif self.score != dealer.score or self.bust?
      return PlayerLoses.new
    end
    PlayerPush.new
  end

  private
    def has_blackjack?
      first_card = @hand[0]
      second_card = @hand[1]
      (first_card.ace? && second_card.value >= 10) ||
        (first_card.value >= 10 && second_card.ace?)
    end

    def add_card_value(card, score_so_far)
      if card.face?
        return 10
      elsif card.ace?
        if (score_so_far + 11) <= BLACKJACK
          return 11
        end
      end 
      return card.value
    end
end
