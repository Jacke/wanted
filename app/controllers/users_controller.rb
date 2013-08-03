class UsersController < ApplicationController

  # страница пользователя
  def show
    @user = User.find_by_id(params[:id]) || current_user
    @items = @user.following_by_type('Item').order("created_at DESC")
    @collections = @user.collections

    respond_to do |format|
      format.html
    end
  end

  def collections
    @user = User.find_by_id(params[:id]) || current_user
    @items = @user.following_by_type('Item')
    @collections = @user.collections
  end

  def collection
    @user = User.find_by_id(params[:id]) || current_user
    @collection = Collection.find_by_id(params[:collection_id])
    @items = @collection.following_by_type('Item').order("created_at DESC")
  end

  def avatar
    @avatar = User.find(params[:id]).avatar.first
    render partial: "shared/avatar"
  end

  def follow
    @user = User.find_by_id(params[:id])
    current_user.follow(@user)
    redirect_to :back
  end

  def unfollow
    @user = User.find_by_id(params[:id])
    current_user.stop_following(@user)
    redirect_to :back
  end
end
