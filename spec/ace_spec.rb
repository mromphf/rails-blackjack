require_relative "../lib/ace.rb"

describe Ace do
  let(:ace) { Ace.new(:hearts) }

  it "is constructed with a suit" do
    expect(ace).to be_a Ace
  end

  it "will throw an exception if given an invalid suit" do
    expect { Card.new(3, :foo) }.to raise_error("ERROR: Cannot create a card with suit: foo.")
  end

  describe "equality" do
    it "is determined when two aces are the same suit" do
      expect(ace).to eq Ace.new(:hearts)
    end

    it "is not equal if the suits are different" do
      expect(ace).not_to eq Ace.new(:clubs)
    end
  end

  it "has a value of 1" do
    expect(ace.value).to eq 1
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
      expect(Ace.new(:spades).to_s).to eq "Ace of Spades"
    end

    it "provides the expected string for hearts" do
      expect(Ace.new(:hearts).to_s).to eq "Ace of Hearts"
    end

    it "provides the expected string for clubs" do
      expect(Ace.new(:clubs).to_s).to eq "Ace of Clubs"
    end

    it "provides the expected string for diamonds" do
      expect(Ace.new(:diamonds).to_s).to eq "Ace of Diamonds"
    end
  end

  describe 'render' do
    it 'provides an img name for spades' do
      expect(Ace.new(:spades).render).to eq 'spades01.png'
    end

    it 'provides an img name for hearts' do
      expect(Ace.new(:hearts).render).to eq 'hearts01.png'
    end

    it 'provides an img name for clubs' do
      expect(Ace.new(:clubs).render).to eq 'clubs01.png'
    end

    it 'provides an img name for diamonds' do
      expect(Ace.new(:diamonds).render).to eq 'diamonds01.png'
    end
  end

  it "is not a face card" do
    expect(Ace.new(:hearts).face?).to eq false
  end
end
