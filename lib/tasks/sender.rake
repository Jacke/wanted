namespace :sender do
  task :put => :environment do
    @items = Item.where("created_at >= ?", 1.week.ago)
    @creators = User.find(@items.uniq.pluck(:user_id))
    @subscribers = @creators.map(&:followers).flatten.uniq if @creators.present?

    if @subscribers.present?
    @subscribers.each do |subscriber|
        if subscriber.present? && @items.where(user_id: subscriber.all_following.uniq).present? 
          UserMailer.sender(@items.where(user_id: subscriber.all_following.uniq), subscriber)
        end
      puts @items.where(user_id: subscriber.all_following.uniq)
      puts subscriber.follows
    end  
    end

  end
end

