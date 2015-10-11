Rails.application.routes.draw do
  root 'auctions#index'

  resources :sellers, only: %i(show history rating) do
    get :show
    get :history
    get :rating
  end

  resources :auctions, only: %i(show)

  namespace :mypage do
    resource :users, only: %i(show edit update)
    resources :products do
      get :exibit, on: :collection
      patch :pullup, on: :member
    end
  end

  devise_for :users
end
