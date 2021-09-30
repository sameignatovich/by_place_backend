class Admin::AuthController < ApplicationController
  before_action :check_admin_access, only: [:autologin, :signout]

  # POST /v1/signin.json
  def signin
    @user = User.find_by_email(user_params[:email])
    if @user.admin and @user.authenticate(user_params[:password])
      token = @user.tokens.create(access: :admin)
      avatar = avatar_url(@user)
      render json: { token: ApplicationJwt.encode(token.id), user: {id: current_user.id, email: current_user.email, fullname: current_user.fullname, username: current_user.username, avatar: avatar }, message: 'Signin successful' }, status: :ok
    else
      render json: {message: 'Wrong email or password'}, status: :not_found
    end
  end

  # DELETE /v1/signout.json
  def signout
    token = ApplicationJwt.decode(received_token)
    Token.find(token).inactive!
    render json: {signout: true}, status: :ok
  end

  # POST /v1/autologin.json
  def autologin
    avatar = avatar_url(current_user)
    render json: { user: { id: current_user.id, email: current_user.email, fullname: current_user.fullname, username: current_user.username, avatar: avatar }, loggedIn: true, message: 'Autologin successful' }, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def avatar_url(user)
      user.avatar.attached? ? polymorphic_url(user.avatar) : nil
    end

    def received_token
      #header: { 'Authorization': 'Bearer <token>' }
      request.headers['Authorization'].split(' ')[1]
    end
end
