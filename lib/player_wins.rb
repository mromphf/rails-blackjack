class PlayerWins
  def save(user, bet)
    user.win!(bet)
  end
end

class PlayerLoses
  def save(user, bet)
    user.lose!(bet)
  end
end

class PlayerPush
  def save(user, bet)
  end
end
