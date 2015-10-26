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

    # ちゃんと値が返されるか不安になるかもしれませんが最後のtitleはこの場合不要です。
    # そうなるとtitleという変数自体いらなくなるので
    # def get_title_of_products(status)
    #   case status.to_i
    #   when Product::PUBLISHED
    #     '出品中の商品一覧'
    #   when Product::UNUSED
    #     '出品終了分の商品一覧'
    #   else
    #     '商品一覧'
    #   end
    # end
    # と書けます
  end

  def interval(type, from, to)
    return 0 if from > to || !%i(year month day).include?(type)
    to.send(type) - from.send(type)
  end

  def expiration?(date)
    interval(:day, Time.now, date) == 0 ? false : true
    # ややこしいので interval(:day, Time.now, date) != 0
    # だけにすれば、三項演算子はいらない
  end

  def judged?(seller_id, bidder_id)
    Rating.exists?(seller_id: seller_id, bidder_id: bidder_id)
  end
  # この3つはモデルメソッドに移動したら、引数を減らせそう
end
