class User < ActiveRecord::Base
  BLACKJACK = 21

  :has_secure_password

  attr_accessor :password, :password_confirmation

  def settle!(bet, player_score, dealer_score)
    if (player_score > dealer_score || dealer_score > BLACKJACK) && player_score < BLACKJACK
      self.money += bet
    elsif (player_score != dealer_score)
      self.money -= bet
    end
    save
  end
end
