class Player
  def initialize(cards=[])
    @cards = cards
  end

  def add_card(card)
    Player.new(@cards << card)
  end

  def score
    score = 0
    @cards.each do |card|
      score += card.value
    end
    score
  end
end
