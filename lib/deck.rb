class Deck
  def initialize
    @cards = [] << Ace.new(:spades)
    12.times do |i|
      @cards << Card.new(i + 2, :spades)
    end
    @cards << Ace.new(:hearts)
    12.times do |i|
      @cards << Card.new(i + 2, :hearts)
    end
    @cards << Ace.new(:clubs)
    12.times do |i|
      @cards << Card.new(i + 2, :clubs)
    end
    @cards << Ace.new(:diamonds)
    12.times do |i|
      @cards << Card.new(i + 2, :diamonds)
    end
  end

  def deal_card
    @cards.pop
  end
end
