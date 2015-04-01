class User < ActiveRecord::Base
  :has_secure_password

  attr_accessor :password, :password_confirmation

  def win(cash)
    self.money += cash
  end
end
