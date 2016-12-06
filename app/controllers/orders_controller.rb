class OrdersController < ApplicationController
  def index
    @orders = HTTParty.get('http://localhost:8082/orderservice/order',
    :headers =>{'Content-Type' => 'application/json'} )
    @orders = @orders.sort_by {|order| order["orderdate"]}.reverse
  end

  def cancel
    @result = HTTParty.patch('http://localhost:8082/orderservice/cancelorder', 
      :body => {:orderID => params[:orderID]}.to_json, 
      :headers => { 'Content-Type' => 'application/json' })
    redirect_to orders_index_path
    flash[:notice] = 'An order for "' + params[:productname] + '" has been cancelled.'
  end
end