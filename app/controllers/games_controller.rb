class GamesController < ApplicationController
  def show
    session[:drawn_cards] = []
    session[:player_cards] = []
    session[:dealer_cards] = []
  end
  
  def player_hit
    draw_new_card(:player_cards)
  end

  def dealer_hit
    draw_new_card(:dealer_cards)
  end

  private
    def draw_new_card(session_var)
      drawn_cards = CardSerializer.deserialize(session[:drawn_cards])
      player_cards = CardSerializer.deserialize(session[session_var])
      card = Deck.new.deal_card(drawn_cards)
      player_cards << card
      drawn_cards << card
      player = Player.new(player_cards)
      session[:drawn_cards] = CardSerializer.serialize(drawn_cards)
      session[session_var] = CardSerializer.serialize(player_cards)
      render :json => { text: card.to_s, 
                        score: player.score, 
                        blackjack: player.blackjack?,
                        bust: player.bust? }
    end
end
