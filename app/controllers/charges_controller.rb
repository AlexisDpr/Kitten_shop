class ChargesController < ApplicationController
  def new
    begin
      @cart = Cart.find_by(user_id: current_user.id)
      if @cart.nil?
        flash[:notice] = "Votre panier est vide. Ajoutez des articles avant de procéder au paiement."
        redirect_to root_path
      else
        @total_price = @cart.total_price || 0
      end
    rescue => e
      flash[:error] = "Une erreur s'est produite : #{e.message}"
      redirect_to root_path
    end
  end

  def create
    @cart = Cart.find(params[:cart_id])
    @amount = (@cart.total_price * 100).to_i  # Assuming total_price is in dollars.
      
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'usd',
      })

      # Création de commandes pour chaque produit dans le panier
      @cart.selections.each do |selection|
        current_user.orders.create!(product_id: selection.product_id)
      end

      # Destruction du panier
      @cart.destroy
      session[:cart_id] = nil
      
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
end
