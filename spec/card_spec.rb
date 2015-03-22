require_relative "../lib/card.rb"

describe Card do
  let(:card) { Card.new(2, :hearts) }

  describe "constructor" do
    it "takes in a suit and a value" do
      expect(card).to be_a Card
    end

    it "will throw an exception if given a value of one" do
      expect { Card.new(1, :diamonds) }.to raise_error
    end
  end

  describe "value" do
    it "will always be 10 for jacks" do
      expect(Card.new(11, :clubs).value).to eq 10
    end

    it "will always be 10 for queens" do
      expect(Card.new(12, :clubs).value).to eq 10
    end

    it "will always be 10 for kings" do
      expect(Card.new(13, :clubs).value).to eq 10
    end
  end

  describe "equality" do
    it "is true when the values of the card are the same" do
      expect(Card.new(7, :hearts)).to eq Card.new(7, :clubs) 
    end

    it "is not true when the values of the card are NOT the same" do
      expect(Card.new(8, :hearts)).not_to eq Card.new(7, :clubs) 
    end
  end

  describe "comparability" do
    it "is determined by the value of the card first" do
      cards = [Card.new(3, :hearts), Card.new(11, :club), Card.new(7, :spades)]
      cards.sort
      expect(cards[2]).to eq Card.new(7, :spades)
    end
  end 

  it "knows when it is a face card" do
    expect(Card.new(11, :hearts).face?).to eq true
  end

  it "knows when it is NOT a face card" do
    expect(Card.new(10, :spades).face?).to eq false
  end

  it "is not an ace" do
    expect(Card.new(2, :diamonds).ace?).to eq false
  end
end
