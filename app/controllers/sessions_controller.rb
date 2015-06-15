class SessionsController < ApplicationController
  before_filter :check_session, except: :destroy

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    log_in(user)
    redirect_to '/play'
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
