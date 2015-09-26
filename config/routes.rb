Rails.application.routes.draw do
  root 'tops#index'

  namespace :mypage do
    resource :users, only: %i(show edit update)
    resources :products do
      get :exibit, on: :collection
      patch :pullup, on: :member
    end
  end

  devise_for :users
end
