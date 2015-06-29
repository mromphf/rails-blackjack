module SessionsHelper
  def log_in(user)
    session[:logged_in] = true
    session[:current_user_id] = user.id
  end

  def log_in_guest
    session[:logged_in] = true
    session[:guest_mode] = true
    session[:guest_money] = 200
    session[:guest_bet] = 10
  end

  def log_out
    session[:logged_in] = false
    session[:current_user_id] = nil
  end

  def logged_in?
    session[:logged_in] == true ? true : false
  end

  def current_user
    if session[:guest_mode] = true
      Guest.new(session)
    else
      User.find(session[:current_user_id].to_i)
    end
  end
end
