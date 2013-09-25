class Item < ActiveRecord::Base
  require 'open-uri'
  before_create :picture_from_url

  #acts_as_votable
  acts_as_taggable
  acts_as_followable
  is_impressionable
  
  attr_accessible :followable_id, :followable_type, :followers_count_cache
  attr_accessible :clothes, :comment, :name, :prise, :sex, :tag_list, :shop_id, :url, :image_url, :count_user_followers, :raiting
  #paperclip
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "230x180#",:mediump => "120x120#",:small => "115x100#",:big => "390>x" }, 
                            :default_url => "/images/default/items/:style/missing.png",
                            :url => "/images/system/items/:id/:style/:id.:extension"

  # Relations
  #===============================================================
  belongs_to  :user, :counter_cache => true 
  belongs_to  :shop
  has_many    :comments, dependent: :delete_all

  # Validations
  #===============================================================
  #validates :comment, presence: true
  validates_attachment :image, 
                      :content_type => { :content_type => /image/ },
                      :size => { :in => 0..1000.kilobytes }
#  after_save :new_item_notice

  
  private

  def picture_from_url
    unless self.image_url.blank?
      self.image = open(self.image_url)
    end
  end

  def new_item_notice
    UserMailer.item_notice(self).deliver
  end

end
