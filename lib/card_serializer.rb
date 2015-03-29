class CardSerializer
  STRING_SUITS = { "Spades" => :spades, "Hearts" => :hearts, "Clubs" => :clubs, "Diamonds" => :diamonds }

  def self.deserialize(data)
    cards = []
    data.each do |item|
      elements = item.split
      value = elements[0].reverse.chomp('"').reverse.to_i
      suit = STRING_SUITS[elements[2].chomp('"')]
      if value == 1
        cards << Ace.new(suit)
      else
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def self.serialize(cards)
    values = []
    cards.each do |card|
      values << "#{card.state[:value]} of #{card.state[:suit]}"
    end
    values
  end
end
