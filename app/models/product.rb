class Product < ActiveRecord::Base
  belongs_to :max_bidding, class_name: 'Bidding'
  belongs_to :seller, class_name: 'User'
  has_many :biddings, dependent: :destroy
  has_many :bidders, class_name: 'User', through: :biddings
end
