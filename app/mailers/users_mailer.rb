class UsersMailer < ApplicationMailer
  def welcome_message
    @user = params[:user]
    @confirmation_url = Rails.configuration.x.app_url + '/signup/email_confirmation/' + @user.email_confirmation_token
    mail(to: @user.email, subject: 'Успешная регистрация на сайте Soligorsk Place')
  end

  def reset_password
    @user = params[:user]
    @reset_url = Rails.configuration.x.app_url + '/signin/reset/' + @user.password_reset_token
    mail(to: @user.email, subject: 'Восстановление пароля на сайте Soligorsk Place')
  end
end