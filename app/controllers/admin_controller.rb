class AdminController < ApplicationController
    def dashboard
        admin_check
    end
    def new
        admin_check
    end
    def create
        admin_check
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
end
