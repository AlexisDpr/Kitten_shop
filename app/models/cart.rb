class Cart < ApplicationRecord
  belongs_to :user
  has_many :selections, dependent: :destroy
  has_many :photos, through: :selections


  def add_photo_to_cart(photo)
    self.photos << photo
  end
  
end