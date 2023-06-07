Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:index, :show]
  resources :carts, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  post '/add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'add_to_cart'
  delete '/remove_from_cart/:product_id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
  get 'users/profile'

  # d'autres routes ici...
end
