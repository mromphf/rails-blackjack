class User < ActiveRecord::Base
  BLACKJACK = 21

  :has_secure_password

  attr_accessor :password, :password_confirmation

  def win!(bet)
    self.money += bet
    save
  end

  def lose!(bet)
    self.money -= bet
    self.money = 0 if self.money < 0
    save
  end
end
