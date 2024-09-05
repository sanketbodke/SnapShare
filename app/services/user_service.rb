# frozen_string_literal: true

class UserService
  def initialize(user)
    @user = user
  end

  def update_password(current_password, new_password, password_confirmation)
    if @user.valid_password?(current_password)
      if @user.update(password: new_password, password_confirmation:)
        'Password updated successfully'
      else
        @user.errors.full_messages
      end
    else
      'Current Password Incorrect'
    end
  end

  def follow(user_to_follow)
    if user_to_follow && !@user.voted_for?(user_to_follow)
      @user.likes(user_to_follow)
      'Follow Successfully'
    else
      'Unable to follow'
    end
  end

  def unfollow(user_to_unfollow)
    if user_to_unfollow && @user.voted_for?(user_to_unfollow)
      @user.unlike(user_to_unfollow)
      'Unfollowed successfully'
    else
      'Unable to unfollow'
    end
  end

  def followers
    @user.votes_for.voters
  end

  def following
    @user.find_voted_items
  end

  def liked_posts
    liked_posts = Post.where(id: @user.votes.up.for_type(Post).pluck(:votable_id))
    liked_posts_count = liked_posts.count

    if liked_posts.present?
      { liked_posts:, liked_posts_count: }
    else
      { liked_posts: [], liked_posts_count: 0 }
    end
  end

  def saved_posts
    saved_posts = Post.where(id: @user.votes.up.for_type(Post).where(vote_scope: 'save').pluck(:votable_id))
    saved_posts_count = saved_posts.count

    if saved_posts.present?
      { saved_posts:, saved_posts_count: }
    else
      { saved_posts: [], saved_posts_count: 0 }
    end
  end

  def commented_posts
    Post.joins(:comments).where(comments: { user_id: @user.id }).distinct
  end
end
