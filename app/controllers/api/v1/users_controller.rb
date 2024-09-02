# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate_request
      before_action :set_user, only: %i[liked_posts]

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

      def follow
        user_to_follow = User.find(params[:id])

        # user to follow exists & Checks if the current user has not already followed the user
        # The voted_for? method returns true if the current user has already cast a vote (followed) for user_to_follow.
        if user_to_follow && !@current_user.voted_for?(user_to_follow)
          # This line casts a “like” vote from the current user to the user they want to follow.
          # In the context of acts_as_votable, a “like” is considered a positive vote.
          @current_user.likes(user_to_follow)
          render json: { message: 'Followed successfully' }, status: :ok
        else
          render json: { error: 'Unable to follow' }, status: :unprocessable_entity
        end
      end

      def unfollow
        user_to_unfollow = User.find(params[:id])

        if user_to_unfollow && @current_user.voted_for?(user_to_unfollow)
          @current_user.unlike(user_to_unfollow)
          render json: { message: 'Unfollowed successfully' }, status: :ok
        else
          render json: { error: 'Unable to unfollow' }, status: :unprocessable_entity
        end
      end

      def followers
        user = User.find(params[:id])
        followers = user.votes_for.voters
        render json: followers, status: :ok
      end

      def following
        following = @current_user.find_voted_items
        render json: following, status: :ok
      end

      def liked_posts
        # votes is an association provided by the acts_as_votable gem,
        # This method filters the votes to include only “up” votes (likes).
        # This method filters the votes to include only those associated with the Post model.
        # pluck(:votable_id) extracts the IDs of the votable items (in this case, Post IDs) from the votes.
        #  Post.where => This query fetches all Post records
        # whose IDs match the array of IDs obtained from the previous step
        liked_posts = Post.where(id: @user.votes.up.for_type(Post).pluck(:votable_id))
        liked_posts_count = liked_posts.count

        if liked_posts.present?
          render json: {
            status: 'success',
            liked_posts:,
            liked_posts_count:
          }, status: :ok
        else
          render json: {
            status: 'success',
            message: 'No liked posts found.',
            liked_posts_count: 0
          }, status: :ok
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
