# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::BaseController
      before_action :set_post, only: %i[like dislike save unsave add_comment]

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

      def like
        if @post.liked_by @current_user
          render json: { status: 'success', message: 'Post liked successfully.', post: @post }, status: :ok
        else
          render json: { status: 'error', message: 'Unable to like post.' }, status: :unprocessable_entity
        end
      end

      def dislike
        if @post.disliked_by @current_user
          render json: { status: 'success', message: 'Post disliked successfully.', post: @post }, status: :ok
        else
          render json: { status: 'error', message: 'Unable to dislike post.' }, status: :unprocessable_entity
        end
      end

      def save
        if @post.liked_by @current_user, vote_scope: 'save'
          render json: { status: 'success', message: 'Post saved successfully.', post: @post }, status: :ok
        else
          render json: { status: 'error', message: 'Unable to save post.' }, status: :unprocessable_entity
        end
      end

      def unsave
        if @post.unliked_by @current_user, vote_scope: 'save'
          render json: { status: 'success', message: 'Post unsaved successfully.', post: @post }, status: :ok
        else
          render json: { status: 'error', message: 'Unable to unsave post.' }, status: :unprocessable_entity
        end
      end

      def add_comment
        comment = @post.comments.build(comment_params.merge(user: @current_user))

        if comment.save
          render json: { status: 'success', message: 'Comment added successfully.', comment: }, status: :created
        else
          render json: { status: 'error', message: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :description, :image)
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end

# The build method is provided by ActiveRecord associations (like has_many).
# It creates a new Comment object that is associated with @post but does not
# yet save it to the database.
