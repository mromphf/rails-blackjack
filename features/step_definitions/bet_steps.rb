Given(/^I am a user with (\d+) dollars$/) do |cash|
  User.create(username: "testuser", password: "password", password_confirmation: "password", money: cash.to_i)
end

When(/^I bet (\d+) dollars before a game$/) do |bet|
  @bet = bet.to_i
end

When(/^I win the game$/) do
  User.find_by_username('testuser').win!(@bet)
end

When(/^I lose the game$/) do
  User.find_by_username('testuser').lose!(@bet)
end

Then(/^I should have (\d+) dollars$/) do |cash|
  expect(User.find_by_username('testuser').money).to eq cash.to_i
end

