class UsersController < ApplicationController
  def show
    @user = current_user || User.find_by_id(params[:id])

    respond_to do |format|
      format.html
      format.js { render :pin_avatar }
    end
  end

  def avatar
    @ava = Pin.find(params[:pin_id])
    @comments = @pin.comments.all

    respond_to do |format|
      format.js { render :pin_comments }
    end
  end
end
