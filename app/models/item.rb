class Item < ActiveRecord::Base
  attr_accessible :clothes, :comment, :id_collection, :name, :prise, :sex
  #paperclip
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "230x180#" }, 
                            :default_url => "/images/items/:style/missing.png",
                            :url => "/images/items/:id/:style/:id.:extension"

  # Relations
  #===============================================================
  belongs_to :user

  # Validations
  #===============================================================
  #validates :comment, presence: true

end
