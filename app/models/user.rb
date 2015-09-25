class User < ActiveRecord::Base
  has_many :products, foreign_key: :seller_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
