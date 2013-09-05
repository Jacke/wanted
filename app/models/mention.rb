class Mention < ActiveRecord::Base
  attr_accessible :comment_id, :user_id
  after_save :reply_notice

  belongs_to :comment
  belongs_to :user


def reply_notice
  UserMailer.mention(self).deliver if self.user.reply_notice
end

end
