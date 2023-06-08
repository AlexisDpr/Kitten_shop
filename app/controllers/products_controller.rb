class ProductsController < ApplicationController
    def index
      @products = Product.all
    end
  
    def show
      @product = Product.find(params[:id])
    end

    def edit
      admin_check
      @product = Product.find(params[:id])
    end

    def update
      admin_check
      @product = Product.find(params[:id])
      if @product.update(name: params["name"],price: params["price"],description:params["description"],image: params["url"])
          redirect_to "/products/#{@product.id}"
      else
          redirect_to "/Admin/edit"
      end
  end

  def admin_check
    if current_user
        if current_user.is_admin
        else
            redirect_to"/"
        end
    else
        redirect_to"/"
    end
end
    # Ajoutez ici plus d'actions si nécessaire (par exemple, new, create, edit, update, destroy)
    # si vous voulez permettre aux administrateurs de gérer les produits directement depuis l'application.
  end
  