class Comment < ActiveRecord::Base
  attr_accessible :content, :item_id, :user_id

   # Relations
  #===============================================================
  belongs_to :user
  belongs_to :item
  has_many  :mentions

  # Validations
  #===============================================================
  validates :content, presence: true
end
