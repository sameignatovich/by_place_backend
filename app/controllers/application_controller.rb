class ApplicationController < ActionController::API
  def authorization
    render json: { message: 'Please sign in' }, status: :unauthorized unless logged_in?
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1] # header: { 'Authorization': 'Bearer <token>' }
      begin
        token_hash = JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
        return token_hash[0]['data']
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    Token.find(decoded_token).user
  end

  private
    def jwt_secret
      return Rails.application.credentials.jwt_secret!
    end

    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end

    def logged_in?
      !!current_user
    end
end
