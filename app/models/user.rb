class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders

  def current_cart
    if self.current_cart_id
      return Cart.find_by(id: self.current_cart_id)
    else
      cart = self.carts.create
      self.current_cart_id = cart.id
      return cart
    end
  end

  def current_cart=(cart)
    self.current_cart_id = cart.id
  end
end
