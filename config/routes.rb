Rails.application.routes.draw do
  root 'sessions#new'

  resources(:sessions, only:[:create, :new, :destroy])

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  match '/', to: 'sessions#new', via: 'post'
  match '/guest_auth', to: "sessions#create_guest", via: 'post'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/play', to: "games#show", via: 'get'
  match '/reset_funds', to: "games#reset_funds", via: 'get'
  match '/bet', to: 'games#bet', via: 'post'
  match '/initialize_game', to: 'games#initialize_game', via: 'post'
  match '/bust', to: 'games#bust', via: 'post'
  match '/decide_results', to: 'games#decide_results', via: 'post'
  match '/player_hit', to: 'games#player_hit', via: 'post'
  match '/dealer_hit', to: 'games#dealer_hit', via: 'post'
end
