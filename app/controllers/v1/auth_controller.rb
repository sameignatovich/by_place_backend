class V1::AuthController < ApplicationController
  jwt_secret = Rails.application.credentials.jwt_secret!

  # POST /v1/signin.json
  def signin
    @user = User.find_by_email(user_params[:email])
    if @user and @user.authenticate(user_params[:password])
      token = jwt_token(@user)
      render json: {token: token, user: {username: @user.username, fullname: @user.fullname}, message: 'Signin successful'}, status: :ok
    else
      render json: {message: 'Wrong email or password'}, status: :unprocessable_entity
    end
  end

  # DELETE /v1/signout.json
  def signout
    token = cookies.signed[:token]
    Token.find(token).inactive!
    cookies.delete :token
    reset_session
    render json: {csrf: form_authenticity_token, signout: true}, status: :ok
  end

  # POST /v1/autologin.json
  def autologin
    if token = cookies.signed[:token]
      begin
        @current_user = Token.find_by(id: token, status: :active).user
        render json: {user: {username: @current_user.username, fullname: @current_user.fullname}, loggedIn: true}, status: :ok
      rescue
        cookies.delete :token
        render json: {loggedIn: false}, status: :ok
      end
    else
      cookies.delete :token
      render json: {loggedIn: false}, status: :ok
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def encode_jwt(token)
      data = {data: @token.id}
      return JWT.encode data, jwt_secret, 'HS256'
    end

    def decode_jwt(token)
      decoded_token = JWT.decode token, jwt_secret, true, { algorithm: 'HS256' }
      return decoded_token[0]['data']
    end

    def jwt_token(user)
      @token = user.tokens.create
      return encode_jwt(@token.id)
    end
end
