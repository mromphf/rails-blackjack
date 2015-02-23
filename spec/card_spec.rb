require_relative "../lib/card.rb"

describe Card do
  let(:card) { Card.new(2, :hearts) }

  describe "constructor" do
    it "takes in a suit and a value" do
      expect(card).to be_a Card
    end
  end

  describe "value" do
    it "will always be 10 for face cards" do
      expect(Card.new(11, :clubs).value).to eq 10
      expect(Card.new(12, :clubs).value).to eq 10
      expect(Card.new(13, :diamonds).value).to eq 10
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

  it "knows when it is an ace card" do
    expect(Card.new(1, :spades).ace?).to eq true
    expect(Card.new(2, :diamonds).ace?).to eq false
  end
end
