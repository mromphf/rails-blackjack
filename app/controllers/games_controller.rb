class GamesController < ApplicationController
  before_filter :authenticate
  before_filter :check_funds, only: :reset_funds
  before_filter :check_broke, only: :show

  def show
    @user = current_user
    save_player_cards([])
    save_dealer_cards([])
    render 'game'
  end

  def reset_funds
    render 'reset'
    current_user.reset_money!
  end

  def bet
    @user = current_user
    bet = params[:bet].to_i
    render current_user.place_bet!(bet)
  end

  def initialize_game
    deck = Deck.new

    player_card_one = deck.deal_card
    deck = deck.remove_card(player_card_one)
    dealer_card = deck.deal_card
    deck = deck.remove_card(dealer_card)
    player_card_two = deck.deal_card

    player = Player.new([player_card_one, player_card_two])
    dealer = Player.new([dealer_card])

    save_player_cards([player_card_one, player_card_two])
    save_dealer_cards([dealer_card])

    render :json => { player_card_one: card_asset_path(player_card_one), 
                      dealer_card: card_asset_path(dealer_card),
                      player_card_two: card_asset_path(player_card_two),
                      player_score: player.score,
                      dealer_score: dealer.score,
                      bet: current_user.bet }
  end
  
  def player_hit
    drawn_cards = all_drawn_cards
    player_cards = CardSerializer.deserialize(session[:player_cards])
    deck = Deck.new.remove_cards(drawn_cards)
    card = deck.deal_card

    player_cards << card
    drawn_cards << card

    player = Player.new(player_cards)
    save_player_cards(player_cards)
    render :json => { image: card_asset_path(card), 
                      score: player.score, 
                      blackjack: player.blackjack?, 
                      bust: player.bust? }
  end

  def dealer_tries_to_win
    keep_trying = true
    num_cards = 0
    card_images = []
    player_cards = CardSerializer.deserialize(session[:player_cards])
    dealer_cards = CardSerializer.deserialize(session[:dealer_cards])

    while keep_trying and num_cards < 10
      drawn_cards = player_cards + dealer_cards
      deck = Deck.new.remove_cards(drawn_cards)
      card = deck.deal_card
      card_images << card_asset_path(card)
      dealer_cards << card
      drawn_cards << card

      player = Player.new(player_cards)
      dealer = Player.new(dealer_cards)

      num_cards += 1
      keep_trying = (dealer.score < player.score) && (dealer.score < 17)
    end
    result = player.determine_result(dealer)
    result.save current_user
    render :json => { number_of_cards: num_cards,
                      images: card_images,
                      score: dealer.score,
                      result: result.render,
                      bust: dealer.bust? }
  end

  def bust
    current_user.lose!
    render nothing: true
  end

  private
    def check_funds
      redirect_to '/play' unless current_user.is_broke?
    end

    def check_broke
      redirect_to '/reset_funds' if current_user.is_broke?
    end

    def authenticate
      redirect_to root_path unless logged_in?
    end

    def card_asset_path(card)
      "#{ActionController::Base.helpers.image_path(card.render)}"
    end

    def save_player_cards(cards)
      session[:player_cards] = CardSerializer.serialize(cards)
    end

    def save_dealer_cards(cards)
      session[:dealer_cards] = CardSerializer.serialize(cards)
    end

    def all_drawn_cards
      CardSerializer.deserialize(session[:player_cards]) + CardSerializer.deserialize(session[:dealer_cards])
    end
end
