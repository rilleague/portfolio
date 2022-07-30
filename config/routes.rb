Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users,
    controllers: { registrations: 'registrations' }
  root to: 'pages#index'
  resources :users, only: [:show, :edit, :update]
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end