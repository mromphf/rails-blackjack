class PlayerPush
  def save(user)
    user.push!
  end

  def render
    'Push...'
  end
end
