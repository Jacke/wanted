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
        @new_events << {eventer: User.find_by_id(event.follower_id),event: User.find_by_id(event.followable_id), time: event.created_at}
      when "Item"
        if !@new_events.last.nil? && @new_events.last[:eventer] == User.find_by_id(event.follower_id) && @new_events.last[:event_name] == 'add_items'
          @new_events.last[:event] << Item.find_by_id(event.followable_id)
        else
          @new_events << {event_name: 'add_items', eventer: User.find_by_id(event.follower_id),event: [Item.find_by_id(event.followable_id)],time: event.created_at}
        end
      end
    end

  end
end
