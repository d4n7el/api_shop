class Admin::CategoriesController < ApplicationController
  before_action :valid_token?, only:[:index, :create, :edit, :update]
  before_action :is_admin?, only:[:index, :create, :edit, :update]
  before_action :set_category, only: [:edit, :update]

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :ok
    else
      render json: category.errors , status: :unprocessable_entity
    end
  end

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def edit
    render json: @category, status: :ok
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: @category.errors , status: :unprocessable_entity
    end
  end

  private 

  def category_params
    params.require(:category).permit(:name, :description , :status, :store_id)
  end

  def set_category 
    @category = Category.find(params[:id])
    render status: :bad_request and return if @category === nil
  end


end
