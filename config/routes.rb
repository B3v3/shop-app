Rails.application.routes.draw do
  devise_for :users

  resources :products
  resources :tags, except: [:edit, :new, :update, :destroy]
  resources :ordered_products, only:   [:create, :destroy]

  get 'cart',     to: 'orders#cart'
  delete 'cart',  to: 'orders#clear_cart'
  put 'cart',     to: 'orders#buy'
  patch 'cart',   to: 'orders#buy'
  get 'history',  to: 'orders#history'

  root            to: 'products#index'
end
