class PlayerLoses
  def save(user, bet)
    user.lose!(bet)
  end
end
