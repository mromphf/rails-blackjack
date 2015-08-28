class Card
  include Comparable

  attr_reader :value

  VALID_SUITS = [ :hearts, :clubs, :diamonds, :spades ]
  SUIT_STRINGS = { spades: "Spades", hearts: "Hearts", clubs: "Clubs", diamonds: "Diamonds" }
  FACE_VALUES = { 11 => "Jack", 12 => "Queen", 13 => "King" }

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_value
    validate_suit
  end

  def to_s
    if ace?
      "Ace of #{SUIT_STRINGS[@suit]}"
    else
      value = @value
      value = FACE_VALUES[@value] if value > 10
      "#{value} of #{SUIT_STRINGS[@suit]}"
    end
  end

  def ==(target)
    (@value == target.value) && (@suit == target.suit)
  end

  def ace?
    @value == 1
  end

  def face?
    @value > 10
  end
  
  def render
    suit = SUIT_STRINGS[@suit].downcase
    value = @value
    value = "0#{value}" if value < 10
    "#{suit}#{value}.png"
  end

  def serialize
    "#{@value} of #{SUIT_STRINGS[@suit]}"
  end

  protected
    attr_reader :suit

    def validate_suit
      if not VALID_SUITS.include?(@suit)
        raise "ERROR: Cannot create a card with suit: #{@suit}."
      end
    end

  private
    def validate_value
      if @value >= 14
        raise "ERROR: A card cannot be assigned a value of #{@value}."
      end
    end
end
