require_relative "../lib/player.rb"

describe Player do
  let (:player) { Player.new } 
  
  describe "constructor" do
    it "can take in 0 parameters" do
      expect(player).to be_a Player
    end

    it "can take in an array of cards" do
      card_one = Card.new(3, :hearts)
      card_two = Card.new(12, :clubs)
      expect(Player.new([card_one, card_two])).to be_a Player
    end
  end
end
