#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :nickname, :login, :sex, :sity, :about, :provider, :uid, :url
  # attr_accessible :title, :body
  
  # Relations
  #===============================================================


  # Validations
  #===============================================================
  validates_presence_of :name

  #== Class Methods ==============================================
  class << self
    
    def find_for_provider_oauth(auth, signed_in_resource=nil)
      #raise auth.inspect
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        case auth.provider.to_sym
          when :vkontakte
            params  = { name:auth.info.name,
                        nickname:auth.info.nickname || auth.extra.raw_info.domain,
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.extra.raw_info.uid.to_s+'@vk.com',
                        password:Devise.friendly_token[0,20],
                        url:auth.info.urls.Vkontakte,
                        sex:auth.extra.raw_info.sex }
          when :mailru
            params  = { name:auth.info.name,
                        nickname:auth.info.nickname,
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.info.email,
                        password:Devise.friendly_token[0,20] }
        end

        user = User.create(params)
      end
      user
    end
  end

end
