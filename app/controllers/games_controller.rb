class GamesController < ApplicationController
  def show
    @user = User.find(1)
    session[:drawn_cards] = []
    session[:player_cards] = []
    session[:dealer_cards] = []
  end

  def bet
    bet = params[:bet].to_i
    session[:bet] = bet
    render :json => { bet: bet }
  end
  
  def player_hit
    draw_new_card(:player_cards)
  end

  def dealer_hit
    draw_new_card(:dealer_cards)
  end

  def win
    User.find(1).win!(session[:bet])
    render nothing: true
  end

  def lose
    User.find(1).lose!(session[:bet])
    render nothing: true
  end

  def decide_results
    player = Player.new(CardSerializer.deserialize(session[:player_cards]))
    dealer = Player.new(CardSerializer.deserialize(session[:dealer_cards]))
    if player.score > dealer.score
      User.find(1).win!(session[:bet])
      text = "<strong>You win!!</strong>"
    elsif player.score == dealer.score
      text = "Draw..."
    else 
      User.find(1).lose!(session[:bet])
      text = "Dealer wins..."
    end
    render :json => { text: text }
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
