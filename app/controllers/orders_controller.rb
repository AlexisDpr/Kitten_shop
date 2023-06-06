class OrdersController < ApplicationController
    before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté
  
    def create
      @order = Order.new(user: current_user, product: Product.find(params[:product_id]))
      if @order.save
        # Rediriger vers la page de paiement ou effectuer le paiement ici.
        # Vous pouvez également envoyer un e-mail de confirmation de commande ici.
      else
        # Gérer les erreurs de validation ici.
      end
    end
  
    def show
      @order = Order.find(params[:id])
    end
  end
  