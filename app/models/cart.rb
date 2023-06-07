# Définissons la classe `Cart` qui hérite de `ApplicationRecord`.
# `ApplicationRecord` est une classe de Rails qui représente les modèles qui sont enregistrés dans la base de données.
class Cart < ApplicationRecord

  # Une instance de `Cart` appartient à une instance de `User`. 
  # C'est une association un-à-un entre les modèles `User` et `Cart`.
  belongs_to :user
  
  # Une instance de `Cart` peut avoir plusieurs `Selections` associées. 
  # Si une instance de `Cart` est supprimée, toutes les `Selections` associées sont également supprimées grâce à l'option `dependent: :destroy`.
  has_many :selections, dependent: :destroy

  has_many :products, through: :selections

  def add_product_to_cart(product)
    self.products << product

  end
  
end
