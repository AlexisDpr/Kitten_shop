Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:index, :show]
  resources :carts, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  post 'add_to_cart', to: 'carts#add_to_cart', as: 'add_to_cart'
  # d'autres routes ici...
end
