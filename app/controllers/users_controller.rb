class UsersController < ApplicationController
  before_filter :new, :check_session

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to '/play'
    else
      render 'new'
    end
  end

  private
    def check_session
      redirect_to root_path if logged_in?
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
