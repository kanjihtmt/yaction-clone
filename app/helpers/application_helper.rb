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
    Bidding.new.interval(from, to)
  end
end
