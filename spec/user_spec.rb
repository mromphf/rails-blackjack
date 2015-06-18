require 'spec_helper'

describe User do
  let(:user) { User.new(money: 200) }

  it "wins money" do
    user.money = 200
    user.win!(10)
    User.find(1).money.should == 210
  end

  describe "losing money" do
    it "has money subtracted from its balance" do
      user.money = 200
      user.lose!(10)
      User.find(1).money.should == 190
    end

    it "cannot have less than 0 zero dollars" do
      user.money = 50
      user.lose!(60)
      User.find(1).money.should == 0
    end
  end

  it "has its money reset" do
    user.money = 0
    user.reset_money!
    user.money.should == 200
  end
end
