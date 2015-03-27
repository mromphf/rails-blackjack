class GamesController < ApplicationController
  def hit
    render :json => { text: "You have hit!" }
  end

  def stand
    render :json => { text: "You stand..." }
  end
end
