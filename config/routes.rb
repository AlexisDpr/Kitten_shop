Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:index, :show]
  resources :carts, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  # d'autres routes ici...
end
