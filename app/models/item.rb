class Item < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  acts_as_followable
  
  attr_accessible :clothes, :comment, :collection_id, :name, :prise, :sex, :tag_list
  #paperclip
  attr_accessible :image
  has_attached_file :image, {:styles => { :medium => "230x180#",:small => "115x100#",:big => "390x" }, 
                              :default_url => "/images/system/items/:style/missing.png"
                              }.merge(PAPERCLIP_STORAGE_OPTIONS)

  # Relations
  #===============================================================
  belongs_to  :user
  has_many    :comments

  # Validations
  #===============================================================
  #validates :comment, presence: true

end
