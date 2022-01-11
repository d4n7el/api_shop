require 'jwt'
class ApplicationController < ActionController::API

  def token(user_id)
    JWT.encode({user_id: user_id}, hmac_secret, 'HS256')
  end

  def hmac_secret
    ENV["API_SECRET_KEY"]
  end

  def current_user
    begin
      token = request.headers["Authorization"].split(' ')[1]
      decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
      payload = decoded_array.first
    rescue 
      render json: {error: 'Unauthorized'}, status: :unauthorized  
      return 
    end
    User.find(payload['user_id'])
  end

  def auth_user?
    render json: {error: 'Unauthorized'}, status: :unauthorized if !!!current_user
  end
end
