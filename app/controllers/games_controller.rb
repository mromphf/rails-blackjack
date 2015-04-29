class GamesController < ApplicationController
  BLACKJACK = 21

  def show
    @user = User.find_by_username('admin')
    session[:drawn_cards] = []
    session[:player_cards] = []
    session[:dealer_cards] = []
  end

  def bet
    @user = User.find_by_username('admin')
    bet = params[:bet].to_i
    render_player_bet(@user, bet)
  end
  
  def player_hit
    draw_new_card(:player_cards)
  end

  def dealer_hit
    draw_new_card(:dealer_cards)
  end

  def bust
    User.find_by_username('admin').lose!(session[:bet])
    render nothing: true
  end

  def decide_results
    player = Player.new(CardSerializer.deserialize(session[:player_cards]))
    dealer = Player.new(CardSerializer.deserialize(session[:dealer_cards]))
    result = Player.determine_result(player, dealer)
    result.execute(User.find_by_username('admin'), session[:bet])
    render :json => { text: player.render_result(dealer) } 
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
      render :json => { text: card.render, 
                        score: player.score, 
                        blackjack: player.blackjack?,
                        bust: player.bust? }
    end

    def render_player_bet(user, bet)
      if bet <= user.money
        session[:bet] = bet
        render :json => { bet: bet }
      else
        render nothing: true
      end
    end
end
