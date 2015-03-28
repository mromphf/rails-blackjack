Rails.application.routes.draw do
  root 'games#show'
  match('/', to: 'games#show', via: 'get')
  match('/hit', to: 'games#hit', via: 'get')
  match('/stand', to: 'games#stand', via: 'get')
end
