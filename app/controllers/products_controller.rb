class ProductsController < ApplicationController
  def index
    if params[:search]
      @products = HTTParty.get('http://localhost:8082/productservice/products/' + params[:search],
      :headers =>{'Content-Type' => 'application/json'} )
      if @products.empty?
        redirect_to products_index_path
        flash[:notice] = 'No product with the keyword "' + params[:search] + '" has been found.'
      end
    else
      @products = HTTParty.get('http://localhost:8082/productservice/product',
      :headers =>{'Content-Type' => 'application/json'} )
      @products = @products.sort_by {|product| product["productname"]}
      if @products.empty?
        redirect_to products_index_path
        flash[:notice] = 'There is no product in the service database.'
      end
    end
    
  end

  def show
    @product = Product.find(params[:id])
  end

  def buy
    @result = HTTParty.post('http://localhost:8082/orderservice/order', 
      :body => {:username => current_user.username, :productname => params[:productname], :productqty => 1, :amount => params[:amount]}.to_json, 
      :headers => { 'Content-Type' => 'application/json' })
    redirect_to products_index_path
    flash[:notice] = 'An order for "' + params[:productname] + '" has been made.'
  end
end
