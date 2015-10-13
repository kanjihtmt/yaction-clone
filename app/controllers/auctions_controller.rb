class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: %i(bid)
  before_action :set_product, only: %i(show set_price)

  def index
    @products = Product.where(status: Product::PUBLISHED)
  end

  def show
  end

  def set_price
    if @product.seller == current_user
      redirect_to auction_path(@product), alert: '出品者は入札できません' and return
    end
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
