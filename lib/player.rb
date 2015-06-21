require_relative "player_wins"
require_relative "player_push"
require_relative "player_loses"

class Player
  BLACKJACK = 21
  FACE_CARD_VALUE = 10
  ACES_HIGH_VALUE = 11

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
    if (self.score > dealer.score and not self.bust?) or dealer.bust?
      return '<strong>You win!!</strong>'
    elsif self.score != dealer.score or self.bust?
      return 'Dealer wins...'
    end
    'Push...'
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
        return FACE_CARD_VALUE
      elsif card.ace?
        if (score_so_far + ACES_HIGH_VALUE) <= BLACKJACK
          return ACES_HIGH_VALUE
        end
      end 
      return card.value
    end
end
