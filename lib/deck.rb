class Deck
  NUMBER_OF_NON_ACE_CARDS = 12
  SUITS = [:spades, :hearts, :clubs, :diamonds]

  def initialize(cards=Deck.full_deck)
    @cards = cards
  end

  def remove_card(card)
    @cards.delete(card)
    Deck.new(@cards)
  end

  def remove_cards(cards)
    cards.each { |card| @cards.delete(card) }
    Deck.new(@cards)
  end

  def deal_card
    random_index = (Random.rand(1..@cards.size) - 1)
    @cards[random_index]
  end

  private
    def self.full_deck
      cards = []
      SUITS.each do |suit|
        cards << Ace.new(suit)
        NUMBER_OF_NON_ACE_CARDS.times do |i|
          cards << Card.new(i + 2, suit)
        end
      end
      cards
    end
end
