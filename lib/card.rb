class Card
  include Comparable

  VALID_SUITS = [ :hearts, :clubs, :diamonds, :spades ]

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_value
    validate_suit
  end

  def ==(target)
    @value == target.value
  end

  def <=>(target)
    @value <=> target.value
  end

  def value(cards=[])
    return @value if @value <= 10
    10
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
