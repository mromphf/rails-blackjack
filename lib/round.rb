class Round
  def self.determine_result(player, dealer)
    return PlayerWins.new if player.blackjack?
    if (player.score > dealer.score and not player.bust?) or dealer.bust?
      return PlayerWins.new
    elsif player.score != dealer.score or player.bust?
      return PlayerLoses.new
    end
    PlayerPush.new
  end
end
