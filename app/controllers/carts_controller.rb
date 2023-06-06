class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy add_to_cart]
  before_action :owner?, only: [:show, :destroy, :edit, :update]
  before_action :total_of_cart, only: [:show]
  

  def index
    @carts = Cart.all
  end


  def add_to_cart
    @product = Product.find(params[:id])

    if user_signed_in?
      @cart = Cart.find_by(user_id: current_user.id)
      @cart.add_product_to_cart(@product)
      redirect_to products_path, notice: "Photo ajoutée au panier"
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
  end

  def new
    @cart = Cart.new
  end

  def edit
  end

  def create
    @cart = Cart.create(user_id: current_user.id)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), flash: { success: "Votre panier a été mis à jour." } }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, flash: { success: "La photo a été supprimée de votre panier." } }
      format.json { head :no_content }
    end
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