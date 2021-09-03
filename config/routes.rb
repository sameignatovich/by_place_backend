Rails.application.routes.draw do
  namespace :v1 do
    resources :places, only: [:index, :show], param: :uri

    controller :auth do
      post 'autologin'
      post 'signin'
      delete 'signout'
    end

    controller :users do
      get 'users', to: 'users#index'
      get 'profile/:username', to: 'users#show'
      put 'profile/update/main', to: 'users#update'
      put 'profile/update/avatar', to: 'users#update_avatar'
      post 'signup', to: 'users#create'
      post 'user/confirm', to: 'users#confirm'
      post 'user/reset_request', to: 'users#reset_request'
      patch 'user/reset', to: 'users#reset'
    end
  end

  namespace :admin do
    controller :auth do
      post 'autologin'
      post 'signin'
      delete 'signout'
    end
    
    controller :users do
      get 'users', to: 'users#index'
    end

    controller :places do
      get 'places', to: 'places#index'
      post 'places', to: 'places#create'
      delete 'places/:id', to: 'places#destroy'
    end
  end
end
