class User < ActiveRecord::Base
  BLACKJACK = 21
  
  has_secure_password
  validates(:username, presence: true, 
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Username must be a valid email address." },
            on: :create)
  validates(:password, length: { minimum: 4 }, on: :create)

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def win!(bet)
    self.money += bet
    save!
  end

  def lose!(bet)
    self.money -= bet
    self.money = 0 if self.money < 0
    save!
  end

  def reset_money!
    self.money = 200
    save!
  end
end
