class User < ActiveRecord::Base
  has_many :products, foreign_key: :seller_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 4, maximum: 31 }
end
