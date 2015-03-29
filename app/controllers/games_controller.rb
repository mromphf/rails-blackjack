class GamesController < ApplicationController
  def show
    session[:drawn_cards] = []
  end
  
  def hit
    drawn_cards = Card.deserialize(session[:drawn_cards])
    card = Deck.new.deal_card(drawn_cards)
    player = Player.new(drawn_cards)
    session[:drawn_cards] = Card.serialize(drawn_cards << card)
    render :json => { text: card.to_s, 
                      score: player.score, 
                      blackjack: player.blackjack?,
                      bust: player.bust? }
  end
end
