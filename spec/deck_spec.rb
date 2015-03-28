require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Deck do
  let (:deck) { Deck.new }

  describe "last three cards" do
    it "will have the king of diamonds last" do
      deck.deal_card!.should == Card.new(13, :diamonds)
    end

    it "will have the queen of diamonds second to last" do
      deck.deal_card!
      deck.deal_card!.should == Card.new(12, :diamonds)
    end

    it "will have the queen of diamonds second to last" do
      deck.deal_card!
      deck.deal_card!
      deck.deal_card!.should == Card.new(11, :diamonds)
    end
  end

  it "can deal a random card" do
    deck.random_card.should be_a Card || Ace
  end
end
