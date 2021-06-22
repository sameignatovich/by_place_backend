class V1::AuthController < ApplicationController
  before_action :authorization, only: [:autologin]
  
  # POST /v1/signin.json
  def signin
    @user = User.find_by_email(user_params[:email])
    if @user and @user.authenticate(user_params[:password])
      token = jwt_token(@user)
      avatar = polymorphic_url(@user.avatar)
      render json: {token: token, user: {username: @user.username, fullname: @user.fullname, avatar: avatar}, message: 'Signin successful'}, status: :ok
    else
      render json: {message: 'Wrong email or password'}, status: :unprocessable_entity
    end
  end

  # DELETE /v1/signout.json
  def signout
    token = decode_jwt(params[:token])
    Token.find(token).inactive!
    render json: {signout: true}, status: :ok
  end

  # POST /v1/autologin.json
  def autologin
    render json: {user: {email: current_user.email, fullname: current_user.fullname, username: current_user.username, avatar: polymorphic_url(current_user.avatar)}, loggedIn: true}, status: :ok
  end

  private
    def jwt_secret
      return Rails.application.credentials.jwt_secret!
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def encode_jwt(token)
      data = {data: @token.id}
      return JWT.encode data, jwt_secret, 'HS256'
    end

    def jwt_token(user)
      @token = user.tokens.create
      return encode_jwt(@token.id)
    end
end
