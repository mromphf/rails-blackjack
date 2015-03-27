Rails.application.routes.draw do
  root 'games#index'
  resources :games
  match('/hit', to: 'games#hit', via: 'get')
  match('/stand', to: 'games#stand', via: 'get')
end
