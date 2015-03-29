class GamesController < ApplicationController
  def show
    session[:drawn_cards] = []
  end
  
  def hit
    drawn_cards = Card.deserialize(session[:drawn_cards])
    card = Deck.new.deal_card(drawn_cards)
    session[:drawn_cards] = Card.serialize(drawn_cards << card)
    render :json => { text: card.to_s }
  end

  def stand
    render :json => { text: "You stand..." }
  end
end
