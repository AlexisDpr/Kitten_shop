class ProductsController < ApplicationController
    def index
      @products = Product.all
    end
  
    def show
      @product = Product.find(params[:id])
    end
  
    # Ajoutez ici plus d'actions si nécessaire (par exemple, new, create, edit, update, destroy)
    # si vous voulez permettre aux administrateurs de gérer les produits directement depuis l'application.
  end
  