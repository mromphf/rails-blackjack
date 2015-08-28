require_relative "../lib/deck.rb"
require_relative "../lib/card.rb"

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
      expect(Deck.full_deck.count(Card.new(1, :hearts))).to eq 1
      expect(Deck.full_deck.count(Card.new(1, :clubs))).to eq 1
      expect(Deck.full_deck.count(Card.new(1, :diamonds))).to eq 1
      expect(Deck.full_deck.count(Card.new(1, :spades))).to eq 1
    end
  end
end
