Rails.application.routes.draw do
  root 'auctions#index'

  resources :sellers, only: %i(show history rating) do
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
      collection do
        get :bade
        get :exibit
      end
      patch :pullup, on: :member
    end
  end

  devise_for :users
end
