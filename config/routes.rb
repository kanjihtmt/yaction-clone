Rails.application.routes.draw do
  root 'products#index'

  resources :products
  devise_for :users
end
