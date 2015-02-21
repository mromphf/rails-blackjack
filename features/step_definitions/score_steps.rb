require_relative "../../lib/player.rb"
require_relative "../../lib/card.rb"

When(/^the dealer deals me a (\d+) of hearts$/) do |value|
  @player = Player.new
  @player.add_card(Card.new(value, :hearts))
end

When(/^the dealer deals me a (\d+) of clubs$/) do |value|
  @player.add_card(Card.new(value, :clubs))
end

When(/^the dealer deals me a (\d+) of spades$/) do |value|
  @player.add_card(Card.new(value, :spades))
end

Then(/^I should have a total score of (\d+)$/) do |value|
  expect(@player.score).to eq value
end

