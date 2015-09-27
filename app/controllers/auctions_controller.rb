class AuctionsController < ApplicationController
  def index
    @products = Product.where(status: Product::PUBLISHED)
  end

  def show
    @product = Product.find(params[:id])
  end
end
