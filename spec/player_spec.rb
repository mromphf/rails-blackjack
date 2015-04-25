require_relative "../lib/player.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Player do
  let (:player) { Player.new } 
  
  describe "constructor" do
    it "can take in 0 parameters" do
      expect(player).to be_a Player
    end

    it "can take in an array of cards" do
      card_one = Card.new(3, :hearts)
      card_two = Card.new(10, :clubs)
      expect(Player.new([card_one, card_two])).to be_a Player
    end
  end

  describe "being dealt cards" do
    it "can add cards to its hand" do
      player = Player.new.add_card(Card.new(7, :diamonds))
      expect(player).to be_a Player
    end

    it "will update score correctly when given new cards" do
      player = Player.new.add_card(Card.new(6, :clubs))
      expect(player.score).to eq 6
    end
  end

  describe "score " do
    it "is computed by the total value of each card in the players hand" do
      cards = [Card.new(7, :diamonds), Card.new(4, :clubs), Card.new(8, :spades)]
      expect(Player.new(cards).score).to eq 19
    end

    it "will be 21 if the player has one face card and one ace" do
      cards = [ Card.new(11, :spades), Ace.new(:hearts) ]
      expect(Player.new(cards).score).to eq 21
    end

    it "is blackjack when the player has a face card and an ace" do
      cards = [ Card.new(13, :spades), Ace.new(:diamonds) ]
      expect(Player.new(cards).blackjack?).to eq true
    end

    it "always evaluates face cards to a value of ten" do
      card = Card.new(13, :diamonds)
      expect(Player.new([card]).score).to eq 10
    end

    it "will not bust with two face cards" do
      cards = [Card.new(12, :clubs), Card.new(13, :hearts)]
      expect(Player.new(cards).bust?).to eq false
    end
  end

  describe "busting" do
    it "will bust when score exceeds 21" do
      player.stub(:score) { 22 }
      expect(player.bust?).to eq true
    end

    describe "will not bust" do
      it "when score is less than 21" do
        player.stub(:score) { 20 }
        expect(player.bust?).to eq false
      end

      it "when score is equal to 21" do
        player.stub(:score) { 21 }
        expect(player.bust?).to eq false
      end

      it "when given two aces" do
        player = Player.new([Ace.new(:spades), Ace.new(:hearts)])
        expect(player.bust?).to eq false
      end
    end
  end

  it "is equal to another player when they both have the same score" do
    other_player = Player.new
    player.stub(:score) { 20 }
    other_player.stub(:score) { 20 }
    expect(player).to eq other_player
  end

  it "is unequal to another player when they have different scores" do
    other_player = Player.new
    player.stub(:score) { 20 }
    other_player.stub(:score) { 10 }
    expect(player).not_to eq other_player
  end

  describe "rendering result" do
    it "will return 'You win!' if player has a higher score than dealer" do
      player = Player.new([Card.new(10, :hearts), Card.new(9, :spades)])
      dealer = Player.new([Card.new(5, :clubs), Card.new(5, :spades)])
      expect(player.render_result(dealer)).to eq "<strong>You win!!</strong>"
    end

    it "will return 'You win!' if dealer busts" do
      player = Player.new([Card.new(10, :hearts), Card.new(9, :spades)])
      dealer = Player.new([Card.new(10, :clubs), Card.new(10, :spades), Card.new(5, :diamonds)])
      expect(player.render_result(dealer)).to eq "<strong>You win!!</strong>"
    end

    it "will return 'Push...' if it is a draw" do
      player = Player.new([Card.new(10, :hearts), Card.new(9, :spades)])
      dealer = Player.new([Card.new(11, :clubs), Card.new(9, :hearts)])
      expect(player.render_result(dealer)).to eq "Push..."
    end

    it "will return 'Dealer wins...' if the dealer has a higher score" do
      player = Player.new([Card.new(5, :hearts), Card.new(4, :spades)])
      dealer = Player.new([Card.new(11, :clubs), Card.new(9, :hearts)])
      expect(player.render_result(dealer)).to eq "Dealer wins..."
    end

    it "will return 'Dealer wins...' if player busts" do
      player = Player.new([Card.new(13, :hearts), Card.new(12, :spades), Card.new(10, :diamonds)])
      dealer = Player.new([Card.new(11, :clubs), Card.new(9, :hearts)])
      expect(player.render_result(dealer)).to eq "Dealer wins..."
    end
  end
end
