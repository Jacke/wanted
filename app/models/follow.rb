class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes
  attr_accessible :followable_id, :followable_type
  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true
  after_save :follower_notice

  def block!
    self.update_attribute(:blocked, true)
  end

  private
  def follower_notice
     
   if self.followable.follow_notice && !(self.kind_of? Item)
     UserMailer.followed(self).deliver
   end
  end

end
