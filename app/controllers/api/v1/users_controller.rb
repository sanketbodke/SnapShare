# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate_request

      def update_password
        user = User.find_by(id: params[:id])
        if user.valid_password?(params[:current_password])
          if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
            render json: { message: 'Password updated successfully' }, status: :ok
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Current password is incorrect' }, status: :unprocessable_entity
        end
      end
    end
  end
end
