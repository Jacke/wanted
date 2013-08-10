class TapeController < ApplicationController
  def index
    @followers = current_user.following_by_type('User')

    @events = []
    @new_events = []

    @followers.each do |follower|
      follow = follower.follows.order("created_at DESC").first
      unless follow.blank?
        @from_time = follow.created_at if @from_time.blank? || @from_time < follow.created_at
      end
    end

    @from_time += 1.minutes
  end

  def by_time
    @followers = current_user.following_by_type('User')

    @events = []
    @new_events = []
    from_time = get_next_time(params[:time].to_datetime)

    @followers.each do |follower|
      @events += follower.follows.where{(created_at > from_time - 24.hours - Time.now.hour - 5.hours) & (created_at <= from_time)}
    end

    @events = @events.sort_by { |hsh| -hsh[:id] }
    @events.each do |event|
      case event.followable_type
      when "User"
        @new_events << {eventer: User.find_by_id(event.follower_id),event: User.find_by_id(event.followable_id), time: event.created_at}
      when "Item"
        if !@new_events.last.nil? && @new_events.last[:eventer] == User.find_by_id(event.follower_id) && @new_events.last[:event_name] == 'add_items'
          @new_events.last[:event] << Item.find_by_id(event.followable_id)
          @new_events.last[:time] = event.created_at
        else
          @new_events << {event_name: 'add_items', eventer: User.find_by_id(event.follower_id),event: [Item.find_by_id(event.followable_id)],time: event.created_at}
        end
      end
    end

    render partial: "tape/tape_grid"
  end

  private

  def get_next_time(from_time)
    @followers = current_user.following_by_type('User')

    @followers.each do |follower|
      follow = follower.follows.order("created_at DESC").where{(created_at < from_time)}.first
      unless follow.blank?
        @from_time = follow.created_at if @from_time.blank? || @from_time < follow.created_at
      end
    end
    return @from_time
  end

end
