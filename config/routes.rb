Rails.application.routes.draw do
  resources :users
  post '/users/login', to: 'users#login'
end
