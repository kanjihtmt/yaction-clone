class Bidding < ActiveRecord::Base
  belongs_to :bidder, class_name: 'User'
  belongs_to :product
end
