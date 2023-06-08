class AdminController < ApplicationController
    def dashboard
    end
    def new
    end
    def create
        puts "$" * 60
        puts "ceci est le contenu de params :"
        puts params
        puts "$" * 60
        @product = Product.create(name: params["name"],price: params["price"],description:params["description"],image: params["url"]  )
        puts @product
        puts "done"
        if @product.save
          
           puts "saved"
         redirect_to"/all_product"
        else
          puts "non valide"
        
          redirect_to"/ProductNew"
        end
    end
end
