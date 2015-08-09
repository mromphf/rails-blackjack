require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"
require_relative "../lib/ace.rb"

describe Deck do
  it "deals cards" do
    deck = Deck.new([Card.new(5, :hearts)])
    expect(deck.deal_card).to eq Card.new(5, :hearts)
  end

  it "can have one card removed from the deck" do
    deck = Deck.new([Card.new(5, :hearts), Card.new(6, :spades)])
    deck = deck.remove_card(Card.new(6, :spades))
    expect(deck.deal_card).not_to eq Card.new(6, :spades)
  end

  it "can have multiple cards removed from the deck at once" do
    deck = Deck.new([Card.new(5, :hearts), Card.new(6, :spades), Card.new(7, :clubs)])
    deck = deck.remove_cards([Card.new(6, :spades), Card.new(7, :clubs)])
    expect(deck.deal_card).not_to eq Card.new(6, :spades)
    expect(deck.deal_card).not_to eq Card.new(7, :clubs)
  end

  describe "that is full" do
    it "has 52 cards" do
      expect(Deck.full_deck.size).to eq 52
    end

    it "has one of each ace" do
      expect(Deck.full_deck.count(Ace.new(:hearts))).to eq 1
      expect(Deck.full_deck.count(Ace.new(:clubs))).to eq 1
      expect(Deck.full_deck.count(Ace.new(:diamonds))).to eq 1
      expect(Deck.full_deck.count(Ace.new(:spades))).to eq 1
    end
  end
end
