require 'spec_helper'

describe User do
  let(:user) { User.new(username: "jimbob", 
                        password: "abc123", 
                        password_confirmation: "abc123") }

  it "should be valid with a password" do
    user.should be_valid 
  end

  it "wins money" do
    user.money = 500
    user.win(100)
    user.money.should == 600
  end
end
