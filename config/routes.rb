Rails.application.routes.draw do
  root 'games#show'
  get 'game/' => 'games#show'
end
