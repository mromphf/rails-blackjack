class User < ActiveRecord::Base
  BLACKJACK = 21
  
  has_secure_password
  validates(:username, presence: true, 
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Username must be a valid email address." },
            on: :create)
  validates(:password, length: { minimum: 4 }, on: :create)

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
