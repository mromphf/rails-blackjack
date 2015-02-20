require_relative "../lib/card.rb"

describe Card do
  let(:card) { Card.new(2, :hearts) }

  describe "constructor" do
    it "takes in a suit and a value" do
      expect(card).to be_a Card
    end
  end

  it "can recognize equality to another card" do
    expect(card).to eq Card.new(2, :hearts)
  end
end
