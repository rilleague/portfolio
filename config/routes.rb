Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: 'pages#index'
  resources :users, only: :show
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end
