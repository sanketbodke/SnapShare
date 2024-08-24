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
        end
      end
      resources :posts, only: [:create]
    end
  end
end
