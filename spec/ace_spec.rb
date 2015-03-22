require_relative "../lib/ace.rb"

describe Ace do
  let(:ace) { Ace.new(:hearts) }

  it "is constructed with a suit" do
    expect(ace).to be_a Ace
  end

  it "is equal to another ace of the same " do
    expect(ace).to eq Ace.new(:clubs)
  end

  describe "value" do
    describe "being low" do
      it "when combined with mutliple cards" do
        cards = [ Card.new(3, :hearts), Card.new(13, :clubs) ]
        expect(ace.value(cards)).to eq 1
      end
    end

    describe "being high" do
      it "when combined with one other card" do
        expect(ace.value([Card.new(11, :clubs)])).to eq 11
      end

      it "when combined with multiple cards" do
        cards = [ Card.new(8, :hearts), Card.new(2, :clubs) ]
        expect(ace.value(cards)).to eq 11
      end
    end
  end

  it "is not a face card" do
    expect(ace.face?).to eq false
  end

  it "is an ace" do
    expect(ace.ace?).to eq true
  end
end
