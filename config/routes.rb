Rails.application.routes.draw do
  resources :users
  post '/users/login', to: 'users#login'

  resources :todos
end
