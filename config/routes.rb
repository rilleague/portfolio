Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :posts, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create, :destroy]
  end
end
