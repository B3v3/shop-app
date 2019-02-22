Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  resources :products

  resources :ordered_products, only: [:create, :destroy]

  get 'cart', to: 'orders#cart'
  delete 'cart', to: 'orders#clear_cart'
  put 'cart', to: 'orders#buy'
  patch 'cart', to: 'orders#buy'

  get 'history', to: 'orders#history'

end
