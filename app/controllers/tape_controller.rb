class TapeController < ApplicationController
  def index
    @followers = current_user.following_by_type('User')

    @events = []
    @new_events = []

    @followers.each do |follower|
      @events += follower.follows.order("created_at DESC")
    end

    @events.sort_by { |hsh| hsh[:created_at] }
    @events.each do |event|
      case event.followable_type
      when "User"
        @new_events << {eventer: User.find_by_id(event.follower_id),event: User.find_by_id(event.followable_id)}
      when "Item"
        @new_events << {eventer: User.find_by_id(event.follower_id),event: Item.find_by_id(event.followable_id)}
      end
    end

  end
end
