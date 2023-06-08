class Cart < ApplicationRecord
  belongs_to :user
  has_many :selections, dependent: :destroy
  has_many :products, through: :selections


  def add_product_to_cart(product)
    self.products << product
  end

  def update_quantity(product, quantity)
    selection = selections.find_by(product_id: product.id)
    if selection
      selection.update(quantity: quantity)
    else
      # Gérer le cas où le produit n'est pas dans le panier (par exemple, créer une nouvelle sélection avec la quantité désirée)
    end
  end

  def remove_product_from_cart(product)
    self.products.delete(product)
  end

  def total_price
    products.sum(:price)
  end
  
end
