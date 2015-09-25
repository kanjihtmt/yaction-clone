class Mypage::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.status(params[:status])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.seller = current_user
    if @product.save
      redirect_to @product, notice: '商品を登録しました。'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: '商品を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: '商品を削除しました。'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :start_date, :end_date,
        :image, :image_cache, :image2, :image2_cache, :image3, :image3_cache)
    end
end
