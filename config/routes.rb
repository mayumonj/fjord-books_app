Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'books#index'
end
