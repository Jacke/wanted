namespace :sender do
  task :put => :environment do
    @users = MailLetter.where(sended: false).uniq.pluck(:user_id)
    uarr = []
    @users.each do |u|
      uarr.push(User.find(u))
    end
    uarr.each do |ur|
      mailletters = ur.mail_letters.where(sended: false)
      UserMailer.sender(mailletters, ur).deliver
      mailletters.each {|m| m.update_attribute(:sended, true)}
    end
    
    #@users.first.each do |uid|
    #   u = User.find(uid)
       
    #   MailLetter.where(sended: false, user_id: uid).each do |mail|
    #    UserMailer.sender(mail, u).deliver
    #    mail.update_attribute(:sended, true)
    #  end
    #end

  end
end

