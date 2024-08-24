# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::BaseController
      def create
        if @current_user
          post = @current_user.posts.build(post_params)
          if post.save
            render json: { status: 'success', message: 'Post created successfully.', post: }, status: :created
          else
            render json: { status: 'error', message: post.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :description, :image)
      end
    end
  end
end
