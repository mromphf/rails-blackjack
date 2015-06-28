require 'spec_helper'

describe User do
  let(:user) { User.new(money: 200) }

  it "wins money" do
    user = User.new(money: 190, bet: 10)
    user.win!
    user.money.should == 210
  end

  it "is not broke by default" do
    expect(User.new.is_broke?).not_to eq true
  end

  describe "losing money" do
    it "has money subtracted from its balance" do
      user = User.new(money: 200)
      user.place_bet! 10
      user.lose!
      user.money.should == 190
    end

    it "cannot have less than 0 zero dollars" do
      user = User.new(money: 20)
      user.place_bet! 50
      user.lose!
      user.money.should == 0
    end
  end

  it "will have money removed after placing a bet" do
    user.money = 230
    user.place_bet! 30
    expect(user.money).to eq 200
  end

  it "will have it's money restored after a push" do
    user.money = 200
    user.place_bet! 10
    user.push!
    expect(user.money).to eq 200
  end

  it "is in game after it has placed a bet" do
    user.place_bet! 30
    expect(user.in_game?).to eq true
  end

  describe "is not in a game" do
    it "after winning" do
      user.place_bet! 30
      user.win!
      expect(user.in_game?).to eq false
    end

    it "after losing" do
      user.place_bet! 30
      user.lose!
      expect(user.in_game?).to eq false
    end
  end

  it "has its money reset" do
    user.money = 0
    user.reset_money!
    user.money.should == 200
  end

  it "can be broke" do
    user.money = 0
    expect(user.is_broke?).to eq true
  end

  it "can determine its first name" do
    user.name = "Jim Bob"
    expect(user.first_name).to eq "Jim"
  end
end
