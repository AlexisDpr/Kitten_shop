class Product < ApplicationRecord
    has_many :selections, dependent: :destroy
    has_many :carts, through: :selections
    # autres associations et méthodes
  end
  