Given(/^I am a user with (\d+) dollars$/) do |cash|
  @user = User.create(money: cash.to_i)
end

When(/^I bet (\d+) dollars before a game$/) do |bet|
  @user.place_bet! bet.to_i
end

When(/^I win the game$/) do
  @user.win!
end

When(/^I lose the game$/) do
  @user.lose!
end

When(/^The game is a draw$/) do
  @user.push!
end

Then(/^I should have (\d+) dollars$/) do |cash|
  expect(@user.money).to eq cash.to_i
end

