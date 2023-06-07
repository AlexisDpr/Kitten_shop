class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy add_to_cart]
  before_action :owner?, only: [:show, :destroy, :edit, :update]
  before_action :total_of_cart, only: [:show]
  before_action :set_cart, only: %i[ show edit update destroy add_to_cart remove_from_cart]

  

  def index
    @carts = Cart.all
  end


  def add_to_cart
    @product = Product.find(params[:product_id])
  
    if user_signed_in?
      @cart = Cart.find_or_create_by(user_id: current_user.id)
      @cart.add_product_to_cart(@product)
      redirect_to root_path(anchor: 'portfolio'), notice: "Photo ajoutée au panier"
    else
      session[:product] = @product
      redirect_to new_user_session_path
    end
  end
  
  def total_of_cart
    
      @cart = Cart.find_or_create_by(user_id: current_user.id)
      @total_price_cart = 0
      @cart.products.each do |product|
        @total_price_cart += product.price
      end
      return @total_price_cart
  end

  def show
    @cart = Cart.find_by(user_id: current_user.id)
  
    if @cart.nil?
      flash[:alert] = "Votre panier est vide"
      redirect_to root_path and return
    else
      @products = @cart.products
    end
  end
  

  def new
    @cart = Cart.new
  end

  def edit
  end

  def remove_from_cart
    @product = Product.find(params[:product_id])
    @cart.remove_product_from_cart(@product)
    redirect_to cart_path(@cart), notice: "Produit supprimé du panier."
  end
  

  private
    def set_cart     
      @cart = Cart.find_by(user_id: current_user.id) if current_user 
    end

    def cart_params
      params.fetch(:cart, {})
    end

    def owner?
      @cart = set_cart
      unless @cart && current_user && current_user.id == @cart.user_id  
        flash[:danger] = "Impossible vous n'êtes pas le propriétaire de ce panier !"
        redirect_to "/"
      end
    end
end