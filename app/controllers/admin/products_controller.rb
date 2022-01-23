class Admin::ProductsController < ApplicationController
  before_action :valid_token?, only:[:index, :create, :edit, :update]
  before_action :is_admin?, only:[:index, :create, :edit, :update]
  before_action :set_product, only: [:edit, :update]
  before_action :set_user, only: [:create, :update]

  def index 
    products = Product.all
    render json: products, status: :ok
  end

  def edit
    render json: @product, status: :ok
  end

  def update
    @product.editor_id @user.id
    if  @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors , status: :unprocessable_entity
    end
  end

  def create
    product = Product.new(product_params)
    product.creator_id = @user.id
    product.editor_id = @user.id
    if product.save
      render json: product, status: :ok
    else
      render json: product.errors , status: :unprocessable_entity
    end
  end

  private 

  def set_product
    @product = Product.find(params[:id])
    render status: :bad_request and return if @product === nil
  end

  def product_params
    params.require(:product).permit(:name, :description, :status, :category_id, :creator_id, :editor_id)
  end 

  def set_user 
    @user = current_user
  end
end
