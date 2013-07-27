class UsersController < ApplicationController
  def show
    @user = current_user || User.find_by_id(params[:id])
    @items = @user.items
    @collections = @user.collections

    respond_to do |format|
      format.html
      format.js { render :pin_avatar }
    end
  end

  def collections
    @user = current_user || User.find_by_id(params[:id])
    @items = @user.items
    @collections = @user.collections.all
  end

  def collection
    @user = current_user || User.find_by_id(params[:id])
    @collection = Collection.find_by_id(params[:collection_id])
    @items = @collection.items
  end

  def avatar
    @avatar = User.find(params[:id]).avatar.first
    render partial: "shared/avatar"
  end
end
