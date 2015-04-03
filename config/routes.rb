Rails.application.routes.draw do
  root 'games#show'
  match('/', to: 'games#show', via: 'get')
  match('/bet', to: 'games#bet', via: 'post')
  match('/game_over', to: 'games#game_over', via: 'get')
  match('/player_hit', to: 'games#player_hit', via: 'get')
  match('/dealer_hit', to: 'games#dealer_hit', via: 'get')
  match('/stand', to: 'games#stand', via: 'get')
end
