class PlayerWins
  def save(user, bet)
    user.win!(bet)
  end

  def render
    '<strong>You win!!</strong>'
  end
end
