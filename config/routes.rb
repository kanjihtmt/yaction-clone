Rails.application.routes.draw do
  root 'products#index'
  resources :products

  namespace :mypage do
    resources :users, only: %i(edit)
  end

  devise_for :users
end
