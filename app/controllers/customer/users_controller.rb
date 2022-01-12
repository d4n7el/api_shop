class Customer::UsersController < ApplicationController
  before_action :valid_token?, only:[:edit, :update]
  before_action :is_customer?, only:[:edit, :update]
  before_action :set_user, only: [ :edit, :update]
  
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
    @user = User.find_by(id: current_user.id, role: 'customer')
    render status: :bad_request and return if @user === nil
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :status)
  end
end
