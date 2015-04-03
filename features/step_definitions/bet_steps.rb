Given(/^I am a user with (\d+) dollars$/) do |cash|
  User.create(money: cash.to_i)
end

When(/^I bet (\d+) dollars before a game$/) do |bet|
  @bet = bet.to_i
end

When(/^I win the game$/) do
  User.find(1).win!(@bet)
end

Then(/^I should have (\d+) dollars$/) do |cash|
  expect(User.find(1).money).to eq cash.to_i
end

