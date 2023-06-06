class CartsController < ApplicationController
    before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté
  
    def show
      @cart = current_user.cart
    end
  
    def add_item
      @product = Product.find(params[:product_id])
      current_user.cart.products << @product
      redirect_to cart_path
    end
  
    def remove_item
      @product = Product.find(params[:product_id])
      current_user.cart.products.delete(@product)
      redirect_to cart_path
    end
  end
  