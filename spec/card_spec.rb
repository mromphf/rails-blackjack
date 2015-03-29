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

    it "will throw an exception if given a value greater than thirteen" do
      expect { Card.new(14, :diamonds) }.to raise_error
    end

    it "will throw an exception if given an invalid suit" do
      expect { Card.new(3, :foo) }.to raise_error
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
    it "is true when the values and the suits of the card are the same" do
      expect(Card.new(7, :hearts)).to eq Card.new(7, :hearts) 
    end

    describe "is not true" do
      it "when values are the same but the suits are different" do
        expect(Card.new(8, :hearts)).not_to eq Card.new(8, :clubs) 
      end

      it "when the suits are the same but the values are different" do
        expect(Card.new(11, :hearts)).not_to eq Card.new(13, :hearts) 
      end

      it "when both the values and the suits are different" do
        expect(Card.new(8, :spades)).not_to eq Card.new(13, :hearts) 
      end
    end
  end

  describe "sorting" do
    it "can be done by value" do
      unsorted_cards = [Card.new(11, :hearts), Card.new(3, :hearts), Card.new(7, :hearts)]
      sorted_cards = [Card.new(3, :hearts), Card.new(7, :hearts), Card.new(11, :hearts)]
      expect(unsorted_cards.sort_by { |c| c.value } ).to eq sorted_cards
    end

    it "can be be done first by value then by suit" do
      unsorted_cards = [Card.new(8, :diamonds), Card.new(3, :spades), Card.new(5, :diamonds)]
      sorted_cards = [Card.new(3, :spades), Card.new(5, :diamonds), Card.new(8, :diamonds)]
      expect(unsorted_cards.sort_by { |c| [ c.value, c.suit] }).to eq sorted_cards
    end

    it "will sort by suits according to SHoCkeD sorting method" do
      unsorted_cards = [Card.new(3, :hearts), Card.new(3, :clubs), Card.new(3, :diamonds), Card.new(3, :spades)]
      sorted_cards = [Card.new(3, :spades), Card.new(3, :hearts), Card.new(3, :clubs), Card.new(3, :diamonds)]
      expect(unsorted_cards.sort).to eq sorted_cards
    end
  end 

  it "is not an ace" do
    expect(Card.new(2, :diamonds).ace?).to eq false
  end

  describe "to-string" do
    describe "on non-face cards" do
      it "provides the correct output on spades" do
        Card.new(3, :hearts).to_s.should == "3 of Hearts"
      end

      it "provides the correct output on hearts" do
        Card.new(8, :spades).to_s.should == "8 of Spades"
      end
    end

    describe "on face cards" do
      it "provides the correct output on clubs" do
        Card.new(11, :clubs).to_s.should == "Jack of Clubs"
      end

      it "provides the correct output on diamonds" do
        Card.new(13, :diamonds).to_s.should == "King of Diamonds"
      end
    end
  end

  it "will provide its state in a hashed form" do
    Card.new(13, :hearts).state[:suit].should == "Hearts"
    Card.new(13, :hearts).state[:value].should == 13
  end
end
