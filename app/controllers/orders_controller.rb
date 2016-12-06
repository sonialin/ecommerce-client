class OrdersController < ApplicationController
  require 'will_paginate/array'
  def index
    @orders = HTTParty.get('http://localhost:8082/orderservice/order',
    :headers =>{'Content-Type' => 'application/json'} )
    if current_user.role == 'customer'
      @orders = @orders.select {|order| order["username"] == current_user.username}
    else
      @orders = @orders.select {|order| order["productname"].include?("Samsung")}
    end
    @orders = @orders.sort_by {|order| order["orderdate"]}.reverse
    @orders = @orders.paginate(:page => params[:page], :per_page => 10)
  end

  def cancel
    @result = HTTParty.patch('http://localhost:8082/orderservice/cancelorder', 
      :body => {:orderID => params[:orderID]}.to_json, 
      :headers => { 'Content-Type' => 'application/json' })
    if @result.code == 200
      redirect_to orders_index_path
      flash[:notice] = 'An order for "' + params[:productname] + '" has been cancelled.'
    else
      redirect_to orders_index_path
      flash[:notice] = 'Oops - there was an error.'
    end
  end

  def ship
    @result = HTTParty.patch('http://localhost:8082/orderservice/shiporder', 
      :body => {:orderID => params[:orderID]}.to_json, 
      :headers => { 'Content-Type' => 'application/json' })
    if @result.code == 200
      redirect_to orders_index_path
      flash[:notice] = 'An order for "' + params[:productname] + '" has been shipped.'
    else
      redirect_to orders_index_path
      flash[:notice] = 'Oops - there was an error.'
    end
  end
end