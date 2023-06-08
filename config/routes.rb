Rails.application.routes.draw do
  root 'products#index'
  devise_for :users

  resources :products, only: [:index, :show, :edit ,:update]
  resources :carts, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  resources :charges, only: [:new, :create]


  post '/add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'add_to_cart'
  post 'carts/update_quantity_in_cart', to: 'carts#update_quantity_in_cart', as: 'update_quantity_in_cart'
  post '/test_order/', to: 'carts#test_order', as: 'test_order'
  

  delete '/remove_from_cart/:product_id', to: 'carts#remove_from_cart', as: 'remove_from_cart'

  get 'myprofile', to: 'users#profile', as: 'user_profile'
  get 'mycart', to: 'carts#show', as: 'mycart'
  get 'all_product', to: 'products#showall', as: 'all_product'
  get 'AdminDashboard', to: 'admin#dashboard', as: 'AdminDashboard'
  get 'ProductNew', to: 'admin#new', as: 'ProductNew'
  post '/admin/create', to: 'admin#create'
  post '/products/:product_id/update', to: 'products#update'
  
end
