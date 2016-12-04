class ProductsController < ApplicationController
  def index
    if params[:search]
      @products = HTTParty.get('http://localhost:8082/productservice/products/' + params[:search],
      :headers =>{'Content-Type' => 'application/json'} )
    else
      @products = HTTParty.get('http://localhost:8082/productservice/product',
      :headers =>{'Content-Type' => 'application/json'} )
    end
    
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
