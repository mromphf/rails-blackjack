class GamesController < ApplicationController
  before_filter :authenticate
  before_filter :check_funds, only: :reset_funds
  before_filter :check_broke, only: :show

  def show
    @user = current_user
    session[:drawn_cards] = []
    session[:player_cards] = []
    session[:dealer_cards] = []
  end

  def reset_funds
    render 'reset'
    current_user.reset_money!
  end

  def bet
    bet = params[:bet].to_i
    render_player_bet(bet)
  end
  
  def player_hit
    draw_new_card(:player_cards)
  end

  def dealer_hit
    draw_new_card(:dealer_cards)
  end

  def bust
    current_user.lose!(session[:bet])
    render nothing: true
  end

  def decide_results
    player = Player.new(CardSerializer.deserialize(session[:player_cards]))
    dealer = Player.new(CardSerializer.deserialize(session[:dealer_cards]))
    result = player.determine_result(dealer)
    result.save(current_user, session[:bet])
    render :json => { text: result.render }
  end

  private
    def draw_new_card(session_var)
      drawn_cards = CardSerializer.deserialize(session[:drawn_cards])
      player_cards = CardSerializer.deserialize(session[session_var])
      card = Deck.new(drawn_cards).deal_card
      player_cards << card
      drawn_cards << card
      player = Player.new(player_cards)
      session[:drawn_cards] = CardSerializer.serialize(drawn_cards)
      session[session_var] = CardSerializer.serialize(player_cards)
      render :json => { image: card.render, score: player.score, blackjack: player.blackjack?, bust: player.bust? }
    end

    def render_player_bet(bet)
      if bet <= current_user.money
        session[:bet] = bet
        render :json => { bet: bet }
      else
        render nothing: true
      end
    end

    def check_funds
      redirect_to '/play' unless current_user.is_broke?
    end

    def check_broke
      redirect_to '/reset_funds' if current_user.is_broke?
    end

    def authenticate
      redirect_to root_path if not logged_in?
    end
end
