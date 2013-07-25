class UsersController < ApplicationController
  def show
    @user = current_user || User.find_by_id(params[:id])
    @items = @user.items

    respond_to do |format|
      format.html
      format.js { render :pin_avatar }
    end
  end

  def avatar
    @avatar = User.find(params[:id]).avatar.first
    render partial: "shared/avatar"
  end
end
