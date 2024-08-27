# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      resources :users, only: [] do
        member do
          put :update_password
          put 'follow', to: 'users#follow'
          put 'unfollow', to: 'users#unfollow'
          get 'followers', to: 'users#followers'
          get 'following', to: 'users#following'
        end
      end
      resources :posts, only: [:create]
    end
  end
end
