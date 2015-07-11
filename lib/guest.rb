class Guest
  def initialize(session)
    @session = session
  end

  def money
    @session[:guest_money].to_i
  end

  def bet
    @session[:guest_bet].to_i
  end

  def first_name
    'Guest'
  end

  def place_bet!(bet)
    if can_afford? bet
      @session[:guest_money] -= bet
      @session[:guest_bet] = bet
      return {json: {}}
    else
      return {nothing: true}
    end
  end

  def win!
    @session[:guest_money] += (@session[:guest_bet] * 2)
  end

  def push!
    @session[:guest_money] += @session[:guest_bet]
  end

  def lose!
  end

  def reset_money!
    @session[:guest_money] = 200
  end

  def is_broke?
    @session[:guest_money] <= 0
  end

  private
    def can_afford?(bet)
      self.money >= bet
    end
end
