class TempUsersController < ApplicationController
  include Devise::Controllers::Helpers

  layout 'unregister'
  def index
    render "index"
  end
  def search
    logger.info(params)
    @user =  User.new(email: "temp@email.com", nickname: "test", password: "test123456", name: "Temp user", temp: true)
    @user.save!
    #resource_name = :user
    #resource = warden.authenticate!(:scope => resource_name)
    sign_in(:user, @user)
    logger.info("=============>")
    logger.info(current_user) if current_user.present?
    if current_user.present?
    redirect_to frame_path(site: {url: params[:search][:query]})
    #redirect_to authenticated_root_path 
    else
    redirect_to root_path
    end
    #redirect_to after_sign_in_path_for(@user)
  end

  def update
  end
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
end
