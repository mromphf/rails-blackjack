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
end
