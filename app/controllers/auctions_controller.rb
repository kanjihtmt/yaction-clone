class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: %i(bid)
  before_action :set_product, only: %i(show set_price)

  def index
    @products = Product.where(status: Product::PUBLISHED)
    # ActiveRecord enums だったら、Product.published で取れるscopeが用意されています。
    # もちろんスコープ名がタイポだとエラーになるので、この定数を利用する方法を使わなくて済みます。
  end

  def show
  end

  def set_price
    if @product.seller == current_user
      redirect_to auction_path(@product), alert: '出品者は入札できません' and return
    end
    # ログインしてない状態で入札を押すとエラーが発生します。set_price も authenticate_user 対象かも。
    # こういった 認証系のフィルターはonly指定ではなく、
    # except指定で例外の場合だけを指定して漏れをなくしたほうが新しくメソッドが増えてもデフォルトで
    # 作動するのでいい気がします。
    #
    # それか、ApplicationControllerで before_action :authenticate_user! を呼んであげて、
    # 必要のない所だけ skip_before_action をしたほうが、DRYなコードになると思います。
    @bidding = current_user.biddings.build
    @bidding.product = @product unless @bidding.product
  end

  def bid
    @bidding = current_user.biddings.build(bidding_params)
    if @bidding.save
      redirect_to auction_path(@bidding.product), notice: '入札が完了しました。'
    else
      render :set_price
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def bidding_params
      params.require(:bidding).permit(:product_id, :price)
    end
end
