class PlayerWins
  def save(user)
    user.win!
  end

  def render
    '<strong>You win!!</strong>'
  end
end
