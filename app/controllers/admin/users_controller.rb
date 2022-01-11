class Admin::UsersController < ApplicationController
  before_action :valid_token?, only:[:index, :create, :edit, :update]
  before_action :is_admin?, only:[:index, :create, :edit, :update]
  before_action :set_user, only: [ :edit, :update]
  
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: {users: users}
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
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :store_id, :status, :role)
  end
end
