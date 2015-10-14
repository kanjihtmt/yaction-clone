class Mypage::RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i(new create)

  def new
    @rating = Rating.new(bidder: current_user, seller: @product.seller)
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to bade_mypage_products_path, notice: '評価が完了しました'
    else
      render :new, product_id: @product
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def rating_params
      params.require(:rating).permit(:bidder_id, :seller_id, :value, :comment)
    end
end
