require 'json'

class Card
  include Comparable

  attr_reader :suit

  VALID_SUITS = [ :hearts, :clubs, :diamonds, :spades ]
  SUIT_VALUES = { spades: 1, hearts: 2, clubs: 3, diamonds: 4 }
  SUIT_STRINGS = { spades: "Spades", hearts: "Hearts", clubs: "Clubs", diamonds: "Diamonds" }
  STRING_SUITS = { "Spades" => :spades, "Hearts" => :hearts, "Clubs" => :clubs, "Diamonds" => :diamonds }
  FACE_VALUES = { 11 => "Jack", 12 => "Queen", 13 => "King" }

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_value
    validate_suit
  end

  def to_s
    value = @value
    value = FACE_VALUES[@value] if value > 10
    "#{value} of #{SUIT_STRINGS[@suit]}"
  end

  def ==(target)
    (@value == target.state[:value]) && (@suit == target.suit)
  end

  def <=>(target)
    SUIT_VALUES[@suit] <=> SUIT_VALUES[target.suit] 
  end

  def value(cards=[])
    return 10 if @value >= 11
    @value
  end

  def ace?
    false
  end

  def state
    { value: @value, suit: SUIT_STRINGS[@suit] }
  end

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

  private
    def validate_value
      if @value == 1
        raise "ERROR: A card cannot be assigned a value of one."
      end
      if @value >= 14
        raise "ERROR: Cannot create a card with a value greater than thirteen."
      end
    end

  protected
    def validate_suit
      if not VALID_SUITS.include?(@suit)
        raise "ERROR: Cannot create a card with suit: #{@suit}."
      end
    end
end
