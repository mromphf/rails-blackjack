require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Deck do
  let (:deck) { Deck.new }

  it "deals cards" do
    deck.deal_card.should be_a Card
  end

  it "wont't deal a card that's been drawn from the deck" do
    drawn_card = Card.new(10, :hearts)
    Deck.new([drawn_card]).deal_card.should_not == drawn_card
  end

  it "won't deal any aces when all aces have been removed" do
    drawn_cards = [Ace.new(:spades), Ace.new(:hearts), Ace.new(:clubs), Ace.new(:diamonds)]
    deck = Deck.new(drawn_cards)
    deck.deal_card.should_not == Ace.new(:spades)
    deck.deal_card.should_not == Ace.new(:hearts)
    deck.deal_card.should_not == Ace.new(:clubs)
    deck.deal_card.should_not == Ace.new(:diamonds)
  end
end
