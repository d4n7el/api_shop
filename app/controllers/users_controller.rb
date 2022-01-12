class UsersController < ApplicationController
  before_action :valid_token?, only:[:edit, :update]
  before_action :is_customer?, only:[:edit, :update]
  before_action :set_user, only: [ :edit, :update]
  
  def create
    user = User.new(user_params)
    user.role = 'customer'
    user.store_id = nil
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def edit
    render json: @user, status: :ok
  end

  def update
    if @user&.update(user_params)
      render json: @user, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  private 

  def set_user
    @user = User.find_by(id: params[:id], role: 'customer')
    render status: :bad_request and return if @user === nil
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :status)
  end
end
