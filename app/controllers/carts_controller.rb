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
    @cart.selections.each do |selection|
      @total_price_cart += selection.product.price * selection.quantity
    end
    return @total_price_cart
  end
  

  def show
    @cart = Cart.find_by(user_id: current_user.id) || Cart.new
    @products = @cart.products if @cart.persisted?
    total_price = @products&.sum(:price) || 0
    session[:total_price] = total_price
    if @products.blank?
      flash[:alert] = "Votre panier est vide"
      # Pas besoin de rediriger vers la racine. Affichez simplement le message flash sur la page du panier.
    end
  end
  
  def update_quantity_in_cart
    # Trouver le produit concerné
    @product = Product.find(params[:product_id])
    
    # Trouver le panier de l'utilisateur actuel
    @cart = Cart.find_by(user_id: current_user.id)
    
    # Trouver l'objet de sélection qui relie le panier et le produit
    selection = @cart.selections.find_by(product_id: @product.id)
  
    # Vérifier que la sélection existe
    if selection
      # Mettre à jour la quantité sur l'objet de sélection
      selection.update(quantity: params[:quantity])
  
      # Rediriger l'utilisateur vers la page du panier avec un message de confirmation
      redirect_to @cart, notice: 'La quantité a été mise à jour.'
    else
      # Si la sélection n'existe pas, redirigez vers la page du panier avec un message d'erreur
      redirect_to @cart, alert: 'Le produit n\'a pas été trouvé dans votre panier.'
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
  
  def test_order
    (current_user.cart).products.all.each do |product|
      Order.create(user:current_user,product:product)
      current_user.cart.remove_product_from_cart(product)
    end
    redirect_to "/myprofile"
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