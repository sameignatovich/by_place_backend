Rails.application.config.action_mailer.smtp_settings = {
  address: 'soligorsk.place',
  user_name: Rails.application.credentials.dig(:smtp, :user_name),
  password: Rails.application.credentials.dig(:smtp, :password)
}

Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.default_options = {
  from: 'info@soligorsk.place'
}