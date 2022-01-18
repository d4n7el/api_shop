class Seller::CategoriesController < ApplicationController
  before_action :valid_token?, only:[:index, :create, :edit, :update]
  before_action :is_seller?, only:[:index, :create, :edit, :update]

  def index
    categories = Category.find_by(store_id: current_user.store_id)
    render json: categories, status: :ok
  end
end
