class Item < ActiveRecord::Base
  attr_accessible :clothes, :comment, :id_collection, :name, :prise, :sex
  #paperclip
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "120x120#" }, :default_url => "/images/items/:style/missing.png"
end
