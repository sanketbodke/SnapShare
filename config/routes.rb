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
          put :verify_otp
          put 'follow', to: 'users#follow'
          put 'unfollow', to: 'users#unfollow'
          get 'followers', to: 'users#followers'
          get 'following', to: 'users#following'
          get 'liked_posts'
          get 'saved_posts'
        end
      end
      resources :posts, only: [:create] do
        member do
          put 'like'
          put 'dislike'
          put 'save'
          put 'unsave'
        end
      end
    end
  end
end
