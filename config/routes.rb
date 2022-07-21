Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
