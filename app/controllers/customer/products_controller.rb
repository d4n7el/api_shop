class Customer::ProductsController < ApplicationController
  before_action :valid_token?, only:[:index, :edit]
  before_action :is_seller?, only:[:index, :edit]
  before_action :set_product, only: [:edit]

  def index 
    products = Products.all
    render json: products, status: :ok
  end
  
  def edit
    render json: @product, status: :ok
  end

  private 

  def set_product
    @product = Product.find(params[:id])
    render status: :bad_request and return if @product === nil
  end
end
