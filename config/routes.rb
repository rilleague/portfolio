Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end
