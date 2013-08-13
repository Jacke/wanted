class UsersController < ApplicationController
  before_filter :get_foll_counts, only: [:show, :collections, :mentions, :collection]
  # страница пользователя
  def show
    @items = @user.following_by_type('Item').order("created_at DESC")
    @collections = @user.collections
    @mentions = @user.mentions
  end

  def collections
    @items = @user.following_by_type('Item')
    @collections = @user.collections.order("created_at DESC")
    @mentions = @user.mentions
  end

  def mentions
    @items = @user.following_by_type('Item')
    @collections = @user.collections
    @mentions = @user.mentions.order("created_at DESC")
  end

  def collection
    @collection = Collection.find_by_id(params[:collection_id])
    @items = @collection.following_by_type('Item').order("created_at DESC")
    @collections = @user.collections
    @mentions = @user.mentions
  end

  def shops
    @people = User.order('items_count DESC').where(shop: 1)
  end

  def people
    @people = User.order('followers_counter DESC').where(shop: 0)
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
      if @user.followers_counter == 0
        @user.update_attribute(:followers_counter, @user.count_user_followers)
      else
        @user.update_attribute(:followers_counter, @user.followers_counter + 1)
      end
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
    @unfollow_user.update_attribute(:followers_counter, @unfollow_user.followers_counter - 1) unless @unfollow_user.followers_counter == 0
    redirect_to :back
  end

  private

  def get_foll_counts
    @user = User.find_by_id(params[:id]) || current_user
    @foll_users_count = @user.following_by_type('User').where(shop: 0).count
    @foll_shop_count = @user.following_by_type('User').where(shop: 1).count
  end
end
