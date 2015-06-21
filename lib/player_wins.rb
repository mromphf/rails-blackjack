class PlayerWins
  def save(user, bet)
    user.win!(bet)
  end
end
