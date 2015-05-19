class SessionsController < ApplicationController
  before_filter :check_session, except: :destroy

  def create
    submitted_username = params[:session][:username]
    submitted_password = params[:session][:password]
    user = User.find_by(username: submitted_username.downcase)
    if user && user.authenticate(submitted_password)
      log_in user
      redirect_to '/play'
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
    def check_session
      redirect_to '/play' if logged_in?
    end
end
