class UsersController < ApplicationController

  # страница пользователя
  def show
    @user = User.find_by_id(params[:id]) || current_user
    @items = @user.following_by_type('Item').order("created_at DESC")
    @collections = @user.collections
    @mentions = @user.mentions
  end

  def collections
    @user = User.find_by_id(params[:id]) || current_user
    @items = @user.following_by_type('Item')
    @collections = @user.collections
    @mentions = @user.mentions
  end

  def mentions
    @user = User.find_by_id(params[:id]) || current_user
    @items = @user.following_by_type('Item')
    @collections = @user.collections
    @mentions = @user.mentions.order("created_at DESC")
  end

  def collection
    @user = User.find_by_id(params[:id]) || current_user
    @collection = Collection.find_by_id(params[:collection_id])
    @items = @collection.following_by_type('Item').order("created_at DESC")
    @collections = @user.collections
    @mentions = @user.mentions
  end


  def avatar
    @avatar = User.find(params[:id]).avatar.first
    render partial: "shared/avatar"
  end

  def follow
    @user = User.find_by_id(params[:id])

    # увеличение счетчика новых подписчиков
    unless current_user.following?(@user)
      current_user.follow(@user)
      followers_count = @user.followers_new_count + 1
      @user.update_attribute(:followers_new_count, followers_count)
    end

    redirect_to :back
  end

  def unfollow
    @unfollow_user = User.find_by_id(params[:id])

    # уменьшение счетчика новых подписчиков
    follow_link = current_user.follow(@unfollow_user)
    if @unfollow_user.updated_at == follow_link.created_at
      follow_count = @unfollow_user.followers_new_count - 1
      @unfollow_user.update_attribute(:followers_new_count, follow_count)
    end
    current_user.stop_following(@unfollow_user)
    redirect_to :back
  end
end
