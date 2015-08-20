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

  describe "betting" do
    it "will return blank json if it can afford the bet" do
      expect(user.place_bet! 10).to eq json: {}
    end

    it "will return nothing when the user cannot afford the bet" do
      expect(user.place_bet! 1000).to eq nothing: true
    end
  end

  describe "doubling down" do
    it "will earn twice the bet after winning" do
      user = User.new(money: 190, bet: 10)
      user.double_down!
      user.win!
      expect(user.money).to eq 220
    end

    it "will lose twice the bet after losing" do
      user = User.new(money: 190, bet: 10)
      user.double_down!
      user.lose!
      expect(user.money).to eq 180
    end

    it "will have it's original money restored after a push" do
      user = User.new(money: 190, bet: 10)
      user.double_down!
      user.push!
      expect(user.money).to eq 200
    end
  end
end
