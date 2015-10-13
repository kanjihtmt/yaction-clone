class Mypage::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, except: %i(index new create exibit)
  before_action :set_draft_product, only: %i(exibit pullup)

  def index
    @products = Product.where(seller: current_user).status(params[:status])
  end

  def bade
    @biddings = current_user.biddings.where(bidder: current_user)
  end

  def exibit
  end

  def pullup
    unless @product.publishable?
      flash.now['alert'] = 'オークション終了日時が過去になっています。内容を編集してから再度出品して下さい。'
      render :exibit and return
    end

    if @product.published!
      redirect_to exibit_mypage_products_path, notice: "商品ID:#{@product.id}の商品を出品しました。"
    else
      flash.now['alert'] = '出品に失敗しました。'
      render :exibit
    end
  end

  def new
    @product = current_user.products.build
  end

  def edit
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to mypage_products_path, notice: '商品を登録しました。'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to mypage_products_path, notice: '商品を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to mypage_products_url, notice: '商品を削除しました。'
  end

  private
    def set_product
      @product = Product.find_by(id: params[:id], seller: current_user)
    end

    def set_draft_product
      @products = Product.where(seller: current_user, status: Product::DRAFT)
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :start_date, :end_date,
        :image, :image_cache, :image2, :image2_cache, :image3, :image3_cache)
    end
end
