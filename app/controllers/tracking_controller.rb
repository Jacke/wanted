class TrackingController < ApplicationController
  def followers
    @user = User.find_by_id(params[:user_id])
    @followers = @user.user_followers
  end

  def followed_by
    @user = User.find_by_id(params[:user_id])
    @followings = @user.following_by_type('User')
  end

  def followed_by_shop
  end
end
