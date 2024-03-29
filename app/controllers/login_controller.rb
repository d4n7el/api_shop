class LoginController < ApplicationController
  def create
    user = User.find_by("lower(email) = ?", user_params[:email].downcase)
    if user && user.authenticate(user_params[:password])
      render json: { token: token(user.id), user_id: user.id }, status: :created 
    else 
      render json: { errors: [ "Sorry, incorrect email or password" ] }, status: :unprocessable_entity
    end 
  end

  private 
  def user_params
    params.require(:auth).permit(:email, :password)
  end
end