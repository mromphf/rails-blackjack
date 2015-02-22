require_relative "../../lib/player.rb"
require_relative "../../lib/card.rb"

Given(/^I am a player$/) do
  @player = Player.new
end

When(/^the dealer deals me a (\d+) of hearts$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :hearts))
end

When(/^the dealer deals me a (\d+) of clubs$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :clubs))
end

When(/^the dealer deals me a (\d+) of spades$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :spades))
end

When(/^the dealer deals me a (\d+) of diamonds$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :diamonds))
end

Then(/^I should have a total score of (\d+)$/) do |value|
  expect(@player.score).to eq value.to_i
end

Then(/^I should have blackjack$/) do
  expect(@player.score). to eq :blackjack
end

