class ApplicationController < ActionController::API
  def authorization
    render json: { message: 'Please sign in' }, status: :unauthorized unless logged_in?
  end

  def current_user
    if decoded_token
      token = decoded_token[0]['data']
      @user = Token.find(token).user
    end
  end

  private
    def jwt_secret
      return Rails.application.credentials.jwt_secret!
    end

    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end

    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1] # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end

    def logged_in?
      !!current_user
    end
end
