class User < ActiveRecord::Base
  BLACKJACK = 21
  
  has_secure_password
  validates(:username, presence: true, on: :create)
  validates(:password, length: { minimum: 4 }, on: :create)
  validates(:money, presence: true)

  def win!(bet)
    self.money += bet
    save!
  end

  def lose!(bet)
    self.money -= bet
    self.money = 0 if self.money < 0
    save!
  end
end
