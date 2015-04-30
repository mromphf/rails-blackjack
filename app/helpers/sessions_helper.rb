module SessionsHelper
  def log_in(user)
    session[:logged_in] = true
    session[:current_user_id] = user.id
  end

  def log_out
    session[:logged_in] = false
    session[:current_user_id] = nil
  end

  def logged_in?
    session[:logged_in] == true ? true : false
  end

  def current_user
    User.find_by(session[:current_user_id].to_i)
  end
end
