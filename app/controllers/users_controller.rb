class UsersController < ApplicationController
  
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

  private 

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :status)
  end
end
