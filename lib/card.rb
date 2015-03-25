class Card
  include Comparable

  attr_reader :suit

  VALID_SUITS = [ :hearts, :clubs, :diamonds, :spades ]
  SUIT_VALUES = { spades: 1, hearts: 2, clubs: 3, diamonds: 4 }

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_value
    validate_suit
  end

  def ==(target)
    (value == target.value) && (@suit == target.suit)
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

  private
    def validate_value
      if @value == 1
        raise "ERROR: A card cannot be assigned a value of one."
      end
      if @value == 14
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
