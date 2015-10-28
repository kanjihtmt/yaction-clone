module ApplicationHelper
  def get_title_of_products(status)
    case status.to_i
    when Product::PUBLISHED
      '出品中の商品一覧'
    when Product::UNUSED
      '出品終了分の商品一覧'
    else
      '商品一覧'
    end
  end

  def interval(from, to)
    return 0 if from > to
    (to - from).to_i / 864000
  end

  def expiration?(date)
    interval(Time.current, date) < 0
  end

  def judged?(seller_id, bidder_id)
    Rating.exists?(seller_id: seller_id, bidder_id: bidder_id)
  end
  # この3つはモデルメソッドに移動したら、引数を減らせそう
end
