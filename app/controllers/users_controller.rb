class UsersController < ApplicationController
  def show
    @user = current_user || User.find_by_id(params[:id])
  end
end
