require_relative "../lib/player.rb"

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

    it "is computed correctly with aces" do
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
end
