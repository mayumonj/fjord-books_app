Rails.application.routes.draw do
  devise_for :users
  # get '/users/signup', to: 'users#new'
  resources :books
  resources :users
  root 'books#index'
end
