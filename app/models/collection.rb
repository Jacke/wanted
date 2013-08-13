class Collection < ActiveRecord::Base
  acts_as_follower

  attr_accessible :title, :user_id

  # Relations
  #===============================================================
  belongs_to  :user

end
