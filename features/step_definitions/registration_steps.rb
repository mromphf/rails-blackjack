Given(/^I register with a valid email and password$/) do
  User.new(username: "jimbob@email.com", password: "P@ssw0rd", password_confirmation: "P@ssw0rd").save
end

Given(/^I try to register an invalid password$/) do
  @invalid_user = User.new(username: "jimbob@email.com", password: "abc", password_confirmation: "abc")
end

Then(/^I should be saved in the database$/) do
  u = User.find_by(username: "jimbob@email.com")
  expect(u).not_to eq nil
end

Then(/^I should not be saved in the database$/) do
  expect(@invalid_user.save).to eq false
end

Then(/^I should have (\d+) dollars to start with$/) do |cash|
  u = User.find_by(username: "jimbob@email.com")
  expect(u.money).to eq cash.to_i 
end
