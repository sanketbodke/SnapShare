# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :authenticate_request
      before_action :set_user, only: %i[liked_posts saved_posts]

      def update_password
        otp_code = generate_otp_code
        @current_user.update(otp_code:, otp_generated_at: Time.current)
        UserMailer.otp(@current_user, otp_code).deliver_now
        render json: { message: 'OTP has been sent to your email.' }, status: :ok
      end

      def verify_otp
        if params[:otp_code] == @current_user.otp_code && otp_not_expired?(@current_user)
          user_service = UserService.new(@current_user)
          result = user_service.update_password(params[:current_password], params[:new_password],
                                                params[:password_confirmation])

          if result == 'Password updated successfully'
            @current_user.update(otp_code: nil, otp_generated_at: nil)
            render json: { message: result }, status: :ok
          else
            render json: { error: result }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Invalid or expired OTP' }, status: :unprocessable_entity
        end
      end

      def follow
        user_to_follow = User.find(params[:id])
        user_service = UserService.new(@current_user)
        result = user_service.follow(user_to_follow)

        if result == 'Followed successfully'
          render json: { message: result }, status: :ok
        else
          render json: { error: result }, status: :unprocessable_entity
        end
      end

      def unfollow
        user_to_unfollow = User.find(params[:id])
        user_service = UserService.new(@current_user)
        result = user_service.unfollow(user_to_unfollow)

        if result == 'Unfollowed successfully'
          render json: { message: result }, status: :ok
        else
          render json: { error: result }, status: :unprocessable_entity
        end
      end

      def followers
        user_service = UserService.new(User.find(params[:id]))
        followers = user_service.followers
        render json: followers, status: :ok
      end

      def following
        user_service = UserService.new(@current_user)
        following = user_service.following
        render json: following, status: :ok
      end

      def liked_posts
        user_service = UserService.new(@user)
        liked_posts_info = user_service.liked_posts

        render json: {
          status: 'success',
          liked_posts: liked_posts_info[:liked_posts],
          liked_posts_count: liked_posts_info[:liked_posts_count]
        }, status: :ok
      end

      def saved_posts
        user_service = UserService.new(@user)
        saved_posts_info = user_service.saved_posts

        render json: {
          status: 'success',
          liked_posts: saved_posts_info[:saved_posts],
          liked_posts_count: saved_posts_info[:saved_posts_count]
        }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def generate_otp_code
        rand(1000..9999)
      end

      def otp_not_expired?(user)
        user.otp_generated_at && user.otp_generated_at > 10.minutes.ago
      end
    end
  end
end
