module UsersHelper
  def provider? (user)
    user.provider == 'vkontakte'
  end

  def surrogat_email?(user)
    user.email == user.uid.to_s + '@vk.com'
  end
end
