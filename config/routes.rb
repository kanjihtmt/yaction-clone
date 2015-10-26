Rails.application.routes.draw do
  root 'auctions#index'

  resources :sellers, only: %i(show history rating) do
    # resources は RESTful な URL を生成してくれるので、生成される 7メソッド以外は指定しないです。
    # あと SellersController を見ると全て seller_id パラムを使っていますが
    # sellers/:id の URL も生成されていて、そこにアクセスしようとするとエラーになります。
    # memberで書いてあげると、showのように /sellers/:id/history となって :id パラムで取得できるようになります。
    #
    # resources :sellers, only: %i(show) do
    #   member do
    #     get :histroy
    #     get :rating
    #   end
    # end
    # こうなると、SellersController の記述も変わってきます

    get :show
    get :history
    get :rating
  end

  resources :auctions, only: %i(show bid) do
    get :set_price, on: :member
    post :bid, on: :collection
  end

  namespace :mypage do
    resource :users, only: %i(show edit update)
    resources :products, except: %i(show) do
      resource :ratings, only: %i(new create)
      collection do
        get :bade
        get :exibit
      end
      patch :pullup, on: :member
    end
  end

  devise_for :users
end
