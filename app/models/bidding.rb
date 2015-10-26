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

    if (product.max_bidding && product.max_bidding.price >= price) ||
       (product.price && product.price >= price)
      errors.add(:price, 'は現在の最高入札価格以上の金額を入力してください')
    end
  end

  def self.find_group_by(bidder_id)
    sql = "
SELECT
  t1.id as product_id, t1.end_date, t1.name, t2.price, t1.seller_id, t2.bidder_id
FROM
  products as t1
    INNER JOIN
  (SELECT bidder_id, product_id, max(price) as price
   FROM biddings WHERE bidder_id = ? GROUP BY bidder_id, product_id) as t2
    ON (t1.id = t2.product_id)"

    #　Biddingモデルなのに products テーブルに biddings を結合していて違和感

    find_by_sql [sql, bidder_id]
  end
end
