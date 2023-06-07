class Cart < ApplicationRecord
  belongs_to :user
  has_many :selections, dependent: :destroy
  has_many :products, through: :selections


  def add_product_to_cart(product)
    self.products << product
  end

  def remove_product_from_cart(product)
    self.products.delete(product)
  end

  def total_price
    products.sum(:price)
  end
  
end
