Rails.application.routes.draw do
  root 'tops#index'

  namespace :mypage do
    resource :users, only: %i(show edit update)
    resources :products
  end

  devise_for :users
end
