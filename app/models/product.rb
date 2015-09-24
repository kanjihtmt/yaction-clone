class Product < ActiveRecord::Base
  enum status: %i(draft published unused)

  DRAFT = 0.freeze
  PUBLISHED = 1.freeze
  UNUSED = 2.freeze

  belongs_to :max_bidding, class_name: 'Bidding'
  belongs_to :seller, class_name: 'User'
  has_many :biddings, dependent: :destroy
  has_many :bidders, class_name: 'User', through: :biddings

  mount_uploader :image, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
end
