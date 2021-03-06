class TapeController < ApplicationController
  def index
    @followers = current_user.following_by_type('User')

    @events = []
    @new_events = []

    # получаем время последнего действия
    unless @followers.empty?
      @followers.each do |follower|
        follow = follower.follows.order("created_at DESC").first
        unless follow.blank?
          @from_time = follow.created_at if @from_time.blank? || @from_time < follow.created_at
        end
      end
      @from_time += 1.minutes
    else
      @from_time = 'stop'
    end
  end

  def by_time
    @followers = current_user.following_by_type('User')
    if params[:time] == 'stop'
      return false
    end
    from_time = get_next_time(params[:time].to_datetime)

    # создаем массив подписок за последние сутки с полученной даты
    @events = []
    @followers.each do |follower|
      @events += follower.follows.where{(created_at > from_time - 24.hours - Time.now.hour - 5.hours) & (created_at <= from_time)}
    end
    @events = @events.sort_by { |hsh| -hsh[:id] }

    # создаем массив действий
    @new_events = []
    @events.each do |event|
      case event.followable_type
      when "User"
        @new_events << {eventer: User.find(event.follower_id),event: User.find(event.followable_id), time: event.created_at}
      when "Item"
        if !@new_events.last.nil? && @new_events.last[:eventer] == User.find(event.follower_id) && @new_events.last[:event_name] == 'add_items'
          @new_events.last[:event] << Item.find(event.followable_id)
          @new_events.last[:time] = event.created_at
        else
          @new_events << {event_name: 'add_items', eventer: User.find(event.follower_id),event: [Item.find(event.followable_id)],time: event.created_at,last_time: event.created_at}
        end
      end
    end

    render partial: "tape/tape_grid"
  end

  private

  #получаем время следующего действия
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
