class TrackingController < ApplicationController
  def followers
    @user = User.find_by_id(params[:user_id])
    @followers = @user.user_followers.order("created_at DESC")
    if @user == current_user
      current_user.update_attribute(:followers_new_count, 0)
    end
  end

  def followed_by
    @user = User.find_by_id(params[:user_id])
    @followings = @user.following_by_type('User').order("created_at DESC").where(shop: 0)
  end

  def followed_by_shop
    @user = User.find_by_id(params[:user_id])
    @followings = @user.following_by_type('User').order("created_at DESC").where(shop: 1)
  end

  def unfollow
    @unfollow_user = User.find_by_id(params[:id])

    follow_link = current_user.follow(@unfollow_user)
    if @unfollow_user.updated_at == follow_link.created_at
      follow_count = @unfollow_user.followers_new_count - 1
      @unfollow_user.update_attribute(:followers_new_count, follow_count)
    end
    current_user.stop_following(@unfollow_user)

    @user = current_user
    @followings = current_user.following_by_type('User')

    render partial: 'follow_elements'
  end
end
