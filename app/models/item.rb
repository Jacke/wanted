class Item < ActiveRecord::Base
  acts_as_votable
  
  attr_accessible :clothes, :comment, :collection_id, :name, :prise, :sex
  #paperclip
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "230x180#",:small => "115x100#",:big => "390x" }, 
                            :default_url => "/images/system/items/:style/missing.png",
                            :url => "/images/system/items/:id/:style/:id.:extension"

  # Relations
  #===============================================================
  belongs_to  :user
  belongs_to  :collection
  has_many    :comments

  # Validations
  #===============================================================
  #validates :comment, presence: true

end
