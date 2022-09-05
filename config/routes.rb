# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show] do
    member do
      get :followees, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
end
