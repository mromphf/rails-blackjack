require 'spec_helper'

describe User do
  it "should be valid with a password" do
    User.new(username: "jimbob", password: "abc123", password_confirmation: "abc123").should be_valid
  end
end
