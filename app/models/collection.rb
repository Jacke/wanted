class Collection < ActiveRecord::Base
  attr_accessible :title, :user_id

  # Relations
  #===============================================================
  has_many    :items
  belongs_to  :user

end
