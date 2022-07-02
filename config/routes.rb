Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show]
  post '/followees/:followee_id', to: 'follows#create', as: 'follow'
  delete '/followees/:followee_id', to: 'follows#destroy', as: 'unfollow'
  get '/users/:user_id/followees', to: 'follows#followees', as: 'followees'
  get '/users/:user_id/followers', to: 'follows#followers', as: 'followers'
end
