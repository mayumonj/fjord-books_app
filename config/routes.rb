# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show] do
    resources :relationships, only: %i[create destroy]
    member do
      get :followees, :followers
    end
  end
end
