class Item < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  acts_as_followable
  
  attr_accessible :clothes, :comment, :collection_id, :name, :prise, :sex, :tag_list
  #paperclip
  attr_accessible :image
  if not Rails.env.production?
    has_attached_file :image, :styles => { :medium => "230x180#",:small => "115x100#",:big => "390x" }, 
                              :default_url => "/images/system/items/:style/missing.png",
                              :url => "/images/system/items/:id/:style/:id.:extension"
  else
    has_attached_file :image, :styles => { :medium => "230x180#",:small => "115x100#",:big => "390x" }, 
                              #:default_url => "/images/system/items/:style/missing.png",
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
  has_many    :comments

  # Validations
  #===============================================================
  #validates :comment, presence: true

end
