class Cart < ApplicationRecord
  belongs_to :user
  has_many :selections, dependent: :destroy
  has_many :products, through: :selections


  def add_product_to_cart(product)
    self.products << product
  end
  
end