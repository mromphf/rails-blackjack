require_relative "../lib/card.rb"

describe Card do
  let(:card) { Card.new(2, :hearts) }

  describe "constructor" do
    it "takes in a suit and a value" do
      expect(card).to be_a Card
    end
  end

  describe "equals method" do
    it "can recognize two equals card" do
      expect(card).to eq Card.new(2, :hearts)
    end

    it "can recognize two unequal cards" do
      expect(card).not_to eq Card.new(3, :spades)
    end
  end

  it "knows when it is a face card" do
    expect(Card.new(11, :hearts).face?).to eq true
    expect(Card.new(12, :spades).face?).to eq true
    expect(Card.new(13, :clubs).face?).to eq true

    expect(Card.new(10, :spades).face?).to eq false
    expect(Card.new(1, :spades).face?).to eq false
    expect(Card.new(3, :diamonds).face?).to eq false
  end
end
