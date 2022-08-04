Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users,
    controllers: { registrations: 'users/registrations' }
  root to: 'pages#index'
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resources :relationships, only: [:create, :destroy]
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end