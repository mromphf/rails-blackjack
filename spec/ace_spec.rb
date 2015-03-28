require_relative "../lib/ace.rb"

describe Ace do
  let(:ace) { Ace.new(:hearts) }

  it "is constructed with a suit" do
    expect(ace).to be_a Ace
  end

  it "will throw an exception if given an invalid suit" do
    expect { Card.new(3, :foo) }.to raise_error
  end

  describe "equality" do
    it "is determined when two aces are the same suit" do
      expect(ace).to eq Ace.new(:hearts)
    end

    it "is not equal if the suits are different" do
      expect(ace).not_to eq Ace.new(:clubs)
    end
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

  it "is an ace" do
    expect(ace.ace?).to eq true
  end
  
  it "is sorted by suit using the SHoCkeD method" do
    unsorted_cards = [Ace.new(:clubs), Ace.new(:spades), Ace.new(:diamonds), Ace.new(:hearts)]
    sorted_cards = [Ace.new(:spades), Ace.new(:hearts), Ace.new(:clubs), Ace.new(:diamonds)]
    expect(unsorted_cards.sort).to eq sorted_cards
  end

  describe "to string" do
    it "provides the expected string for spades" do
      Ace.new(:spades).to_s.should == "Ace of Spades"
    end

    it "provides the expected string for hearts" do
      Ace.new(:hearts).to_s.should == "Ace of Hearts"
    end

    it "provides the expected string for clubs" do
      Ace.new(:clubs).to_s.should == "Ace of Clubs"
    end

    it "provides the expected string for diamonds" do
      Ace.new(:diamonds).to_s.should == "Ace of Diamonds"
    end
  end
end
