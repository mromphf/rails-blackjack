require_relative '../lib/guest.rb'

describe Guest do
  let (:guest) { Guest.new({guest_money: 200, guest_bet: 0}) }

  it "is created with a session array" do
    expect(Guest.new([])).to be_a Guest
  end

  it "should have 200 dollars by default" do
    expect(guest.money).to eq 200
  end

  it "should be nothing by default" do
    expect(guest.bet).to eq 0
  end

  describe "betting" do
    context "when user can afford the bet" do
      it "will subtract money from the guest" do
        guest.place_bet! 10
        expect(guest.money).to eq 190
      end

      it "will set the players bet according to the amount bet" do
        guest.place_bet! 10
        expect(guest.bet).to eq 10 
      end

      it "will return some blank json" do
        expect(guest.place_bet! 10).to eq json: {}
      end
    end

    context "when the user cannot afford the bet" do
      it "will return nothing" do
        expect(guest.place_bet! 1000).to eq nothing: true
      end

      it "will not change the users money" do
        guest.place_bet! 1000
        expect(guest.money).to eq 200
      end
    end
  end

  it "will earn twice the amounte bet after winning" do
    guest.place_bet! 10
    guest.win!
    expect(guest.money).to eq 210
  end

  it "will earn its money back after pushing" do
    guest.place_bet! 10
    guest.push!
    expect(guest.money).to eq 200
  end

  it "will have lost its money after losing" do
    guest.place_bet! 10
    guest.lose!
    expect(guest.money).to eq 190
  end

  it "can have its money reset to 200" do
    guest.reset_money!
    expect(guest.money).to eq 200
  end

  describe "being broke" do
    it "is not broke if it has more than 0 dollars" do
      guest.reset_money!
      expect(guest.is_broke?).not_to be true
    end

    it "is broke if it has 0 dollars" do
      guest.place_bet! 200
      guest.lose!
      expect(guest.is_broke?).to be true
    end
  end

  describe "doubling down" do
    it "will earn twice the bet after winning" do
      guest.place_bet! 10
      guest.double_down!
      guest.win!
      expect(guest.money).to eq 220
    end

    it "will lose twice the bet after losing" do
      guest.place_bet! 10
      guest.double_down!
      guest.lose!
      expect(guest.money).to eq 180
    end

    it "will have it's original money restored after a push" do
      guest.place_bet! 10
      guest.double_down!
      guest.push!
      expect(guest.money).to eq 200
    end
  end
end
