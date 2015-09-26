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
end
