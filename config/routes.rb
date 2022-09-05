Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
    resources :comments
  end
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
  resources :reports do
    resources :comments
  end
end
