class ProductsController < ApplicationController
  def index
    @products = HTTParty.get('http://localhost:8082/productservice/product',
    :headers =>{'Content-Type' => 'application/json'} )
  end

  def show
    @product = Product.find(params[:id])
  end
end
