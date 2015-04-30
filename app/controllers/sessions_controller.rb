class SessionsController < ApplicationController
  before_filter :check_session, except: :destroy

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
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
