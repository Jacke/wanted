class Mention < ActiveRecord::Base
  attr_accessible :comment_id, :user_id

  belongs_to :comment
  belongs_to :user
end
