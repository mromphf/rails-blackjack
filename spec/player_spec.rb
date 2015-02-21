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
      new_player = player.add_card(Card.new(7, :diamonds))
      expect(new_player).to be_a Player
    end
  end

  describe "score " do
    it "is computed by the total value of each card in the players hand" do
      new_player = player.add_card(Card.new(7, :diamonds))
      new_player = new_player.add_card(Card.new(4, :clubs))
      new_player = new_player.add_card(Card.new(8, :spades))
      expect(new_player.score).to eq 19
    end

    it "is blackjack when the player has a face card and an ace" do
      new_player = player.add_card(Card.new(1, :diamonds))
      new_player = new_player.add_card(Card.new(13, :spades))
      expect(new_player.score).to eq :blackjack
    end
  end
end
