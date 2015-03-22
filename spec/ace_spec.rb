require_relative "../lib/ace.rb"

describe Ace do
  it "is constructed with a suit" do
    a = Ace.new(:hearts)
    expect(a).to be_a Ace
  end

  describe "value" do
    it "is low to keep the score below 21" do
      cards = [Card.new(10, :spades), Card.new(5, :clubs)]
      ace = Ace.new(:clubs)
      expect(ace.value(cards)).to eq 1
    end
  end
end
