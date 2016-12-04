Rails.application.routes.draw do
  get 'products/index'
  get 'orders/index'
  root :to => "products#index"
  match "products/buy" => "products#buy", as: :products_buy, via: :post
  match "orders/cancel" => "orders#cancel", as: :orders_cancel, via: :patch

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
