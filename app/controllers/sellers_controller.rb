class SellersController < ApplicationController
  before_action :set_seller

  def history
    @products = @seller.products.where(status: Product::PUBLISHED)
  end

  def show
  end

  def rating
  end

  private
    def set_seller
      @seller = User.find(params[:seller_id])
    end
end
