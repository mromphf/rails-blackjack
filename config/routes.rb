Rails.application.routes.draw do
  root 'sessions#new'

  resources(:users, only:[:new, :create])
  resources(:sessions, only:[:create, :new, :destroy])

  match('/', to: 'sessions#new', via: 'get')
  match('/signout', to: 'sessions#destroy', via: 'delete')
  match('/play', to: "games#show", via: 'get')
  match('/bet', to: 'games#bet', via: 'post')
  match('/bust', to: 'games#bust', via: 'get')
  match('/decide_results', to: 'games#decide_results', via: 'get')
  match('/player_hit', to: 'games#player_hit', via: 'get')
  match('/dealer_hit', to: 'games#dealer_hit', via: 'get')
  match('/stand', to: 'games#stand', via: 'get')
end
