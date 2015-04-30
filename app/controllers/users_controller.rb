class UsersController < ApplicationController
  before_filter :new, :check_session

  def new
    @user = User.new
  end

  private
    def check_session
      redirect_to root_path if logged_in?
    end
end
