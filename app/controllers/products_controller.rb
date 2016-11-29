class ProductsController < ApplicationController
  def index
    @products = HTTParty.get('http://localhost:8082/productservice/product',
    :headers =>{'Content-Type' => 'application/json'} )
  end

  def show
    @product = Product.find(params[:id])
  end

  def buy
    @result = HTTParty.post('http://localhost:8082/orderservice/order', 
      :body => {:username => 'sonialin', :productname => params[:productname], :productqty => 1, :amount => params[:amount]}.to_json, 
      :headers => { 'Content-Type' => 'application/json' })
  end
end
