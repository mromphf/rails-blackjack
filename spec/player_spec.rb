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
  end

  describe "score " do
    it "is computed by the total value of each card in the players hand" do
      player = Player.new.add_card(Card.new(7, :diamonds))
      player = player.add_card(Card.new(4, :clubs))
      player = player.add_card(Card.new(8, :spades))
      expect(player.score).to eq 19
    end

    it "is blackjack when the player has a face card and an ace" do
      player = Player.new.add_card(Card.new(1, :diamonds))
      player = player.add_card(Card.new(13, :spades))
      expect(player.blackjack?).to eq true
    end

    it "always evaluates face cards to a value of ten" do
      card = Card.new(13, :diamonds)
      expect(Player.new([card]).score).to eq 10
    end
  end

  it "will bust when score exceeds 21" do
    player = Player.new.add_card(Card.new(10, :hearts))
    player = player.add_card(Card.new(10, :diamonds))
    player = player.add_card(Card.new(3, :clubs))
    expect(player.bust?).to eq true
  end
end
