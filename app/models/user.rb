class User < ActiveRecord::Base
  :has_secure_password

  attr_accessor :password, :password_confirmation

  def win!(bet)
    self.money += (bet * 2)
    save
  end
end
