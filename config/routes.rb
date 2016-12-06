Rails.application.routes.draw do
  devise_for :users
  get 'products/index'
  get 'products/new'
  get 'orders/index'
  root :to => "products#index"
  match "products/buy" => "products#buy", as: :products_buy, via: :post
  match "products/add" => "products#add", as: :products_add, via: :post
  match "orders/cancel" => "orders#cancel", as: :orders_cancel, via: :patch
  match "orders/ship" => "orders#ship", as: :orders_ship, via: :patch

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
