class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders

<<<<<<< HEAD
  after_create :create_cart
  

=======
>>>>>>> d6a539bfb001e3f15c97704831b67b27f4169f96
  def create_cart
    Cart.create!(
      user_id: self.id
    )
  end

end
