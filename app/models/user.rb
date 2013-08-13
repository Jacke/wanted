#encoding: utf-8
class User < ActiveRecord::Base
  acts_as_followable
  acts_as_follower
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :nickname, :login, :sex, :city, :about, :provider, 
                  :uid, :url, :folowers_new_count, :folowed_by_new_count,
                  :phone, :shop, :followers_counter
  #paperclip
  attr_accessible :avatar
  #has_attached_file :avatar,  :styles => { :medium => "120x120#",:small => "50x50#",:esmall => "28x28#"}, 
  #                            :default_url => "/images/system/avatars/:style/missing.png",
  #                            :url => "/images/system/avatars/:id/:style/:id.:extension"
  has_attached_file :avatar,  :styles => { :medium => "120x120#",:small => "50x50#",:esmall => "28x28#"}, 
                              :default_url => "/images/default/avatars/:style/missing.png",
                              :url => "/images/system/avatars/:id/:style/:id.:extension"
  # attr_accessible :title, :body
  
  # Relations
  #===============================================================
  has_many  :items
  has_many  :collections
  has_many  :comments
  has_many  :mentions

  # Validations
  #===============================================================
  validates_presence_of :name
  validates_presence_of :nickname
  validates_presence_of :phone
  validates :nickname, :uniqueness => true

  #== Class Methods ==============================================
  class << self
    
    def find_for_provider_oauth(auth, signed_in_resource=nil)
      #raise auth.inspect
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        case auth.provider.to_sym
          when :vkontakte
            nickname = auth.info.name.gsub(' ', '')
            params  = { name:auth.info.name,
                        nickname:nickname.downcase,
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.extra.raw_info.uid.to_s+'@vk.com',
                        password:Devise.friendly_token[0,20],
                        url:auth.extra.raw_info.photo,
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
