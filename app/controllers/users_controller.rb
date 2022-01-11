class UsersController < ApplicationController
  
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
      if current_user
        users = User.all
        render json: {users: users}
      end
  end

  private 

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
