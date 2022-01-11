class Owner::UsersController < ApplicationController
  before_action :valid_token?, only:[ :create, :edit, :update]
  before_action :is_owner?, only:[:index, :create, :edit, :update]
  before_action :set_user, only: [ :edit, :update]
  before_action :owner_create_user_permit_role? , only: [:create,:update]
  
  def create
    user = User.new(user_params)
    user.store_id = current_user.store_id
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.where(store_id: current_user.store_id)
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
    @user = User.find_by(id: params[:id], store_id: current_user.store_id )
    render status: :bad_request and return if @user === nil
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :status, :role)
  end
end
