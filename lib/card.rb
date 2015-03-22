class Card
  include Comparable

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_params
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
    def validate_params
      if @value == 1
        raise "ERROR: A card cannot be assigned a value of one."
      end
    end
end
