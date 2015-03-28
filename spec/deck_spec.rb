require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Deck do
  let (:deck) { Deck.new }

  it "has a constructor with no arguments" do
    deck.should be_a Deck
  end

  it "will have the king of diamonds as the last card" do
    deck.deal_card.to_s.should == "King of Diamonds"
  end
end
