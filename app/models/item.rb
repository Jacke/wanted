class Item < ActiveRecord::Base
  attr_accessible :clothes, :comment, :collection_id, :name, :prise, :sex
  #paperclip
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "230x180#" }, 
                            :default_url => "/images/items/:style/missing.png",
                            :url => "/images/items/:id/:style/:id.:extension"

  # Relations
  #===============================================================
  belongs_to :user
  belongs_to :collection

  # Validations
  #===============================================================
  #validates :comment, presence: true

end
