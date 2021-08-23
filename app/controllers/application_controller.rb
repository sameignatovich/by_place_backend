class ApplicationController < ActionController::API
  def check_authorization
    render json: { message: 'Unauthorized' }, status: :unauthorized unless logged_in?
  end

  def check_admin_access
    render json: { message: 'Forbidden' }, status: :forbidden unless admin?
  end

  def current_user
    Token.find(ApplicationJwt.decode(received_token)).user
  end

  private
    def received_token
      #header: { 'Authorization': 'Bearer <token>' }
      request.headers['Authorization'].split(' ')[1]
    end

    def logged_in?
      !!current_user
    end

    def admin?
      !!current_user.admin
    end
end
