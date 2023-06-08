class OrdersController < ApplicationController
    before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté
  
    
    def create
      @cart = current_user.cart
      @cart.products.each do |product|
        order = current_user.orders.create!(product: product)
      end
      @cart.selections.delete_all
      redirect_to user_profile_path
    end
  
    def show
      @order = Order.find(params[:id])
    end
  end
  