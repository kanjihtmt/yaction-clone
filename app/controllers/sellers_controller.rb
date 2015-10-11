class SellersController < ApplicationController
  before_action :set_seller

  def history
    @products = @seller.products.page(params[:page]).per(PAGE_MAX)
                    .where(status: Product::PUBLISHED).order(end_date: :desc)
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
