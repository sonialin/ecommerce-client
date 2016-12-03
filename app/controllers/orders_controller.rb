class OrdersController < ApplicationController
  def index
    @orders = HTTParty.get('http://localhost:8082/orderservice/order',
    :headers =>{'Content-Type' => 'application/json'} )  
  end
end