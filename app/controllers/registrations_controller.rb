#encoding: utf-8
class RegistrationsController < Devise::RegistrationsController
 
  def create
    build_resource(sign_up_params)
    resource.password_confirmation = resource.password
    resource.nickname = resource.name
    
    if resource.save
      if resource.active_for_authentication?
        resource.update_attribute(:nickname, resource.id)
        set_flash_message :notice, :signed_up if is_navigational_format?

        sign_up(resource_name, resource)
        return render :json => {:success => true}
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false, :errors => resource.errors.full_messages}
    end
  end

  def update
    @user = User.find(current_user.id)

    if change_surrogat_email?(@user, params)
      params[:user][:email] = @user.email
    end

    params[:user][:nickname].gsub!(' ', '')
    params[:user][:nickname] = params[:user][:nickname].downcase


    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true

      redirect_to edit_user_registration_path
      #redirect_to after_update_path_for(@user)
      #render "edit", :layout => false
    else
      render "edit"
    end
  end

  def update_avatar
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true

      render "show_avatar", :layout => false
    else
      render "edit"
    end
  end
 
  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    #user.email != params[:user][:email] ||
      params[:user][:password].present?
  end

  # если провайдер Вконтакте и контактный емайл не меняли
  def change_surrogat_email?(user,params)
    if params[:user][:email]
      params[:user][:email].empty? && user.provider == 'vkontakte'
    end
  end
 
end