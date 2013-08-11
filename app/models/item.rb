class Item < ActiveRecord::Base
  require 'open-uri'
  before_create :picture_from_url

  #acts_as_votable
  acts_as_taggable
  acts_as_followable
  
  attr_accessible :clothes, :comment, :name, :prise, :sex, :tag_list, :shop_id, :url, :image_url, :count_user_followers
  #paperclip
  attr_accessible :image
  if not Rails.env.production?
    has_attached_file :image, :styles => { :medium => "230x180#",:small => "115x100#",:big => "390>x" }, 
                              :default_url => "/images/default/items/:style/missing.png",
                              :url => "/images/system/items/:id/:style/:id.:extension"
  else
    has_attached_file :image, :styles => { :medium => "230x180#",:small => "115x100#",:big => "390>x" }, 
                              :default_url => "/images/default/items/:style/missing.png",
                              #:url => "/images/system/items/:id/:style/:id.:extension"

                              :storage => :dropbox,
                              :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                              :dropbox_options => {
                                :path => proc { |style| "hochuli/images/system/items/#{id}/#{style}/#{image.original_filename}" }
                                }
  end

  # Relations
  #===============================================================
  belongs_to  :user
  belongs_to  :shop
  has_many    :comments

  # Validations
  #===============================================================
  #validates :comment, presence: true
  validates_attachment :image, 
                      :content_type => { :content_type => /image/ },
                      :size => { :in => 0..1000.kilobytes }

  private

  def picture_from_url
    unless self.image_url.blank?
      self.image = open(self.image_url)
    end
  end

end
