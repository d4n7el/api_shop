require 'jwt'
class ApplicationController < ActionController::API

  # VALIDATE ROLE USER

  def is_admin?
    render status: :unauthorized and return unless current_user.admin?
  end

  def is_owner?
    render status: :unauthorized and return unless current_user.owner?
  end

  def is_seller?
    render status: :unauthorized and return unless current_user.seller?
  end

  def is_customer?
    render status: :unauthorized and return unless current_user.customer?
  end

  # OWNER PERMIT CREATE USER

  def owner_create_user_permit_role?
    render status: :unauthorized and return unless params[:role] === 'customer' || params[:role] === 'seller'
  end

  # AUTH TOKEN 
  def token(user_id)
    JWT.encode({user_id: user_id, time: ( DateTime.now + 1.day ).to_i}, hmac_secret, 'HS256')
  end

  def hmac_secret
    ENV["API_SECRET_KEY"]
  end

  def valid_token?
    token = decode_token
    render status: :unauthorized and return unless decode_token
    render status: :not_acceptable and return if Time.at(token['time']) < Time.now
  end

  def current_user
    User.find(decode_token['user_id'])
  end

  def decode_token 
    begin
      token = request.headers["Authorization"].split(' ')[1]
      decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
      decoded_array.first
    rescue 
      return false
    end
  end

  def auth_user?
    render json: {error: 'Unauthorized'}, status: :unauthorized if !!!current_user
  end
end
