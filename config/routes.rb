Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:index, :show]
  resources :carts, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  post '/add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'add_to_cart'
  post '/test_order/', to: 'carts#test_order', as: 'test_order'
  delete '/remove_from_cart/:product_id', to: 'carts#remove_from_cart', as: 'remove_from_cart'

  get 'myprofile', to: 'users#profile', as: 'user_profile'
  get 'mycart', to: 'carts#show', as: 'mycart'
  # d'autres routes ici...
end
