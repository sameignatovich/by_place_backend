class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /v1/profile/:username.json
  def show
    render json: @user
  end

  # POST /v1/signup.json
  def create
    @user = User.new(user_params)

    if @user.save
      UsersMailer.with(user: @user).welcome_message.deliver_later
      render json: {message: 'Signup successful'}, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /v1/user/confirm.json
  def confirm
    if @user = User.find_by(email_confirmation_token: params[:email_confirmation_token])
      @user.update(email_confirmed: true, email_confirmation_token: nil)
      render json: {message: 'Email confirmed'}, status: :ok
    else
      render json: {message: 'Email confirmation error'}, status: :unprocessable_entity
    end
  end

  # POST /v1/user/reset_request.json
  def reset_request
    if @user = User.find_by(email: user_params[:email])
      if (@user.password_reset_sent_at || DateTime.new(0)) < DateTime.current-1.hour
        @user.update(password_reset_token: SecureRandom.uuid, password_reset_sent_at: DateTime.current)
        UsersMailer.with(user: @user).reset_password.deliver_later
      end
    end
    render json: {message: 'Reset request sent'}, status: :ok # Send this response in any situation for data protection (e.g. email disclosure)
  end

  # PATCH /v1/user/reset.json
  def reset
    if @user = User.find_by(password_reset_token: params[:password_reset_token])
      if (@user.password_reset_sent_at || DateTime.new(0)) > DateTime.current-1.hour
        @user.password = user_params[:password]
        @user.password_confirmation = user_params[:password_confirmation]

        if @user.save
          @user.update(password_reset_token: nil)
          render json: {message: 'Password changed'}, status: :ok
        else
          render json: {message: 'Пароли не совпадают'}, status: :unprocessable_entity
        end
      else
        render json: {message: 'Срок действия ссылки истек'}, status: :unprocessable_entity
      end
    else
      render json: {message: 'Ссылка не верна'}, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find_by(username: params[:username])
    end

    def user_params
      params.require(:user).permit(:username, :fullname, :email, :password, :password_confirmation)
    end
end
