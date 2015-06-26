class PlayerLoses
  def save(user)
    user.lose!
  end

  def render
    'Dealer wins...'
  end
end
