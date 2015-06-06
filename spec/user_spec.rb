require 'spec_helper'

describe User do
  let(:user) { User.new(username: "jimbob@email.com", 
                        password: "abc123", 
                        password_confirmation: "abc123",
                        money: 200) }

  it "should be valid with a password" do
    user.should be_valid 
  end
  
  describe "should not be valid" do
    it "if the username is not an email address" do
      invalid_user = User.new(username: "invalid", password: "password", password_confirmation: "password")
      invalid_user.should_not be_valid
    end

    it "without a password" do
      invalid_user = User.new(username: "invalid@email.com", password: "", password_confirmation: "")
      invalid_user.should_not be_valid
    end
  end

  it "wins money" do
    user.money = 200
    user.win!(10)
    User.find_by_username('jimbob@email.com').money.should == 210
  end

  describe "losing money" do
    it "has money subtracted from its balance" do
      user.money = 200
      user.lose!(10)
      User.find_by_username('jimbob@email.com').money.should == 190
    end

    it "cannot have less than 0 zero dollars" do
      user.money = 50
      user.lose!(60)
      User.find_by_username('jimbob@email.com').money.should == 0
    end
  end

  it "has its money reset" do
    user.money = 0
    user.reset_money!
    user.money.should == 200
  end
end
