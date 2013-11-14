namespace :sender do
  task :put => :environment do
    @items = Item.where("created_at >= ?", 1.week.ago)
    @creators = User.find(@items.uniq.pluck(:user_id))
    @subscribers = @creators.map(&:followers).flatten.uniq if @creators.present?

    @subscribers.each do |subscriber|
        if @items.where(user_id: subscriber.follows.uniq.present?
          UserMailer.sender(@items.where(user_id: subscriber.all_following.uniq), subscriber)
        end
      puts @items.where(user_id: subscriber.all_following.uniq)
      puts subscriber.follows
    end  if @subscribers.present?
    # @users = MailLetter.where(sended: false).uniq.pluck(:user_id)

    # uarr = []
    # @users.each do |u|
    #   uarr.push(User.find(u))
    # end
    # uarr.each do |ur|
    #   mailletters = ur.mail_letters.where(sended: false)
    #   UserMailer.sender(mailletters, ur).deliver
    #   mailletters.each {|m| m.update_attribute(:sended, true)}
    # end
    
    #@users.first.each do |uid|
    #   u = User.find(uid)
       
    #   MailLetter.where(sended: false, user_id: uid).each do |mail|
    #    UserMailer.sender(mail, u).deliver
    #    mail.update_attribute(:sended, true)
    #  end
    #end

  end
end

