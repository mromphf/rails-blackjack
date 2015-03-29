require_relative '../lib/card_serializer'

describe CardSerializer do
  it "can serialize an array of cards with an ace" do
    cards = [Card.new(3, :hearts), Card.new(11, :clubs), Ace.new(:hearts)]
    CardSerializer.serialize(cards).should == ['3 of Hearts', '11 of Clubs', '1 of Hearts']
  end

  it "can serialize an array of cards" do
    cards = [Card.new(3, :hearts), Card.new(11, :clubs)]
    CardSerializer.serialize(cards).should == ['3 of Hearts', '11 of Clubs']
  end

  it "can deserialize an array of card objects" do
    serialized = ['3 of Hearts', '11 of Clubs']
    CardSerializer.deserialize(serialized).should == [Card.new(3, :hearts), Card.new(11, :clubs)]
  end

  it "can deserialize an array of cards with an ace" do
    serialized = ['3 of Hearts', '11 of Clubs', '1 of Spades']
    CardSerializer.deserialize(serialized).should == [Card.new(3, :hearts), Card.new(11, :clubs), Ace.new(:spades)]
  end
end
