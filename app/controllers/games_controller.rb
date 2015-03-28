class GamesController < ApplicationController
  def hit
    deck = Deck.new
    card = deck.random_card
    render :json => { text: card.to_s }
  end

  def stand
    render :json => { text: "You stand..." }
  end
end
