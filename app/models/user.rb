class User < ActiveRecord::Base
  has_many :products, foreign_key: :seller_id
  has_many :ratings, foreign_key: :seller_id
  has_many :biddings, foreign_key: :bidder_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 4, maximum: 31 }
end
