# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_request

      private

      def authenticate_request
        token = request.headers['Authorization']&.split&.last

        return render json: { error: 'Not Authorized' }, status: :unauthorized if token.nil?

        begin
          decoded = JwtHelper.decode(token)
          @current_user = User.find_by(id: decoded&.dig(:user_id))

          render json: { error: 'Not Authorized' }, status: :unauthorized if @current_user.nil?
        rescue StandardError
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end
    end
  end
end
