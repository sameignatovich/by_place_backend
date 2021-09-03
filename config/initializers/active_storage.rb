Rails.application.configure do
  config.active_storage.service_urls_expire_in = 1.hour

  config.active_storage.routes_prefix = '/suf'

  config.active_storage.resolve_model_to_route = :rails_storage_redirect
  # :rails_storage_proxy
end