Rails.application.routes.draw do
  namespace :v1 do
    resources :places, only: [:index, :show], param: :uri
  end
end
