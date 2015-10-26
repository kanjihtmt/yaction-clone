class SellersController < ApplicationController
  before_action :set_seller

  def history
    @products = @seller.products.page(params[:page]).per(PAGE_MAX)
                    .where(status: Product::PUBLISHED).order(end_date: :desc)
  end

  def show
  end

  def rating
    @ratings = @seller.ratings.page(params[:page]).per(PAGE_MAX)
                   .where(value: params[:filter]).order(created_at: :desc)
    @rating = Rating.aggregate(@seller.id)
  end

  private
    def set_seller
      @seller = User.find(params[:id])
    end
end
