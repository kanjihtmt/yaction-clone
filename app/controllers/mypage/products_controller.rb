class Mypage::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, except: %i(index new create exibit)

  def index
    @products = Product.where(seller: current_user).status(params[:status])
  end

  def exibit
    @products = Product.where(seller: current_user, status: Product::DRAFT)
  end

  def pullup
    if @product.publishable?
      redirect_to exibit_mypage_products_path,
        alert: 'オークション終了日時が過去になっています。内容を編集してから再度出品して下さい。' and return
    end

    if @product.published!
      redirect_to exibit_mypage_products_path, notice: "商品ID:#{@product.id}の商品を出品しました。"
    else
      redirect_to exibit_mypage_products_path, alert: '出品に失敗しました。'
    end
  end

  def show
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

    def product_params
      params.require(:product).permit(:name, :description, :price, :start_date, :end_date,
        :image, :image_cache, :image2, :image2_cache, :image3, :image3_cache)
    end
end
