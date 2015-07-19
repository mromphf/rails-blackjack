require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Deck do
  let (:deck) { Deck.new }

  it "deals cards" do
    expect(deck.deal_card!).to be_a Card
  end

  it "wont't deal a card that's been drawn from the deck" do
    drawn_card = Card.new(10, :hearts)
    expect(Deck.new([drawn_card]).deal_card!).not_to eq drawn_card
  end

  it "won't deal any aces when all aces have been removed" do
    drawn_cards = [Ace.new(:spades), Ace.new(:hearts), Ace.new(:clubs), Ace.new(:diamonds)]
    deck = Deck.new(drawn_cards)
    expect(deck.deal_card!).not_to eq Ace.new(:spades)
    expect(deck.deal_card!).not_to eq Ace.new(:clubs)
    expect(deck.deal_card!).not_to eq Ace.new(:hearts)
    expect(deck.deal_card!).not_to eq Ace.new(:diamonds)
  end

  it "will not deal the same card twice" do
    deck = Deck.new()
    card = deck.deal_card!
    expect(deck.deal_card!).not_to eq card
  end
end
