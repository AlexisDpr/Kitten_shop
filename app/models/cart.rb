# Définissons la classe `Cart` qui hérite de `ApplicationRecord`.
# `ApplicationRecord` est une classe de Rails qui représente les modèles qui sont enregistrés dans la base de données.
class Cart < ApplicationRecord

  # Une instance de `Cart` appartient à une instance de `User`. 
  # C'est une association un-à-un entre les modèles `User` et `Cart`.
  belongs_to :user
  
  # Une instance de `Cart` peut avoir plusieurs `Selections` associées. 
  # Si une instance de `Cart` est supprimée, toutes les `Selections` associées sont également supprimées grâce à l'option `dependent: :destroy`.
  has_many :selections, dependent: :destroy
<<<<<<< HEAD
  
  # Une instance de `Cart` peut avoir plusieurs `Photos` à travers l'association `Selections`.
  # Cela signifie que nous pouvons accéder aux photos associées à un panier via ses sélections.
  has_many :photos, through: :selections

  # La méthode `add_photo_to_cart` prend une photo en argument et l'ajoute à l'instance de `Cart`.
  # `self.photos << photo` ajoute l'objet photo à la collection de photos associées à l'instance de `Cart`.
  def add_photo_to_cart(photo)
    self.photos << photo
=======
  has_many :products, through: :selections


  def add_product_to_cart(product)
    self.products << product
>>>>>>> 9ac8ced67b996b144a6a77d89a10f3a87cdfef42
  end
  
end
