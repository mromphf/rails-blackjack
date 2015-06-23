class PlayerLoses
  def save(user, bet)
    user.lose!(bet)
  end

  def render
    'Dealer wins...'
  end
end
