class Deck
  NUMBER_OF_NON_ACE_CARDS = 12

  def initialize
    @cards = []
    add_suit_to_deck(:spades)
    add_suit_to_deck(:hearts)
    add_suit_to_deck(:clubs)
    add_suit_to_deck(:diamonds)
  end

  def deal_card!
    @cards.pop
  end

  private
    def add_suit_to_deck(suit)
      @cards << Ace.new(suit)
      NUMBER_OF_NON_ACE_CARDS.times do |i|
        @cards << Card.new(i + 2, suit)
      end
    end
end
