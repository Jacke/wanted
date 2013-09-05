#encoding: utf-8

class UserMailer < ActionMailer::Base
  default :from => "no-reply@hochuli.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost.com:3000/users/login"
    #mail(:to => user.email, :subject => "Welcome to MySite" :body => "#{user}")
  end
  def confirm(user)
    mail(to: user.email, subject: "Подтвердите регистрацию")
  end

  def mention(mention) 
    # mention.user # user that it mention
    # mention.comment.user # user who mentioned
    @mention = mention
    mail(to: @mention.user.email, subject: " #{@mention.comment.user.name}")
  end
  def followed(follow)
    @follow = follow
    # follow.followable follow.follower
    mail(to: @follow.followable.email, subject: "Вас зафоловил пользователь #{@follow.follower.name}")
  end
  def item_notice(item)
    @item = item
    @item.user.followers.each do |follower|
      if follower.new_item_notice
        @follower = follower
        mail(to: follower.email, subject: "#{@item.user.name} добавил #{@item.name}")
      end
    end
  end

end
