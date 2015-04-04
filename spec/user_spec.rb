require 'spec_helper'

describe User do
  let(:user) { User.new(username: "jimbob", 
                        password: "abc123", 
                        password_confirmation: "abc123",
                        money: 200) }

  it "should be valid with a password" do
    user.should be_valid 
  end

  it "wins money" do
    user.money = 200
    user.win!(10)
    User.find_by_username('jimbob').money.should == 210
  end

  it "loses money" do
    user.money = 200
    user.lose!(10)
    User.find_by_username('jimbob').money.should == 190
  end
end
