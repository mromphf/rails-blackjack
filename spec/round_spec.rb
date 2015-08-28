require_relative "../lib/round.rb"
require_relative "../lib/player_wins.rb"
require_relative "../lib/player_loses.rb"
require_relative "../lib/player_push.rb"

describe Round do
  describe "deciding the winner" do
    context "determines the player wins" do
      it "when the player has a higher score" do
        player = double("Player", score: 20, bust?: false, blackjack?: false)
        dealer = double("Player", score: 18, bust?: false)
        expect(Round.determine_winner(player, dealer)).to be_a PlayerWins
      end

      it "when the dealer busts" do
        player = double("Player", score: 20, bust?: false, blackjack?: false)
        dealer = double("Player", score: 25, bust?: true)
        expect(Round.determine_winner(player, dealer)).to be_a PlayerWins
      end

      it "when the player has blackjack" do
        player = double("Player", score: 21, bust?: false, blackjack?: true)
        dealer = double("Player", score: 21, bust?: false)
        expect(Round.determine_winner(player, dealer)).to be_a PlayerWins
      end
    end

    context "determines the player loses" do
      it "when the dealer has a higher score than the player" do
        player = double("Player", score: 17, bust?: false, blackjack?: false)
        dealer = double("Player", score: 20, bust?: false)
        expect(Round.determine_winner(player, dealer)).to be_a PlayerLoses
      end

      it "when the player busts" do
        player = double("Player", score: 23, bust?: true, blackjack?: false)
        dealer = double("Player", score: 20, bust?: false)
        expect(Round.determine_winner(player, dealer)).to be_a PlayerLoses
      end
    end

    it "determines a push if the scores are the same" do
      player = double("Player", score: 20, bust?: false, blackjack?: false)
      dealer = double("Player", score: 20, bust?: false)
      expect(Round.determine_winner(player, dealer)).to be_a PlayerPush
    end
  end
end
