module ApplicationHelper
  def get_title_of_products(status)
    case status.to_i
      when Product::PUBLISHED
        title = '出品中の商品一覧'
      when Product::UNUSED
        title = '出品終了分の商品一覧'
      else
        title = '商品一覧'
    end

    title
  end

  def interval(type, from, to)
    return 0 if from > to || !%i(year month day).include?(type)
    to.send(type) - from.send(type)
  end

  def expiration?(date)
    interval(:day, Time.now, date) == 0 ? false : true
  end

  def judged?(seller_id, bidder_id)
    Rating.exists?(seller_id: seller_id, bidder_id: bidder_id)
  end
end
