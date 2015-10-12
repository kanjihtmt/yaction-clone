class Bidding < ActiveRecord::Base
  belongs_to :bidder, class_name: 'User'
  belongs_to :product, counter_cache: true
  has_one :max_bidding, class_name: 'Product'

  validates :price, presence: true
  validates :bidder_id, :product_id, presence: true
  validate :max_bid_price

  after_save do
    product.max_bidding = self
    product.save!
  end

  def max_bid_price
    return unless product
    return unless price

    if (product.max_bidding && product.max_bidding.price > price) ||
       (product.price && product.price > price)
      errors.add(:price, 'は現在の最高入札価格以上の金額を入力してください')
    end
  end
end
