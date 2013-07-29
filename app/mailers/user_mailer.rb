class UserMailer < ActionMailer::Base
  default :from => "no-reply@hochuli.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost.com:3000/users/login"
    mail(:to => user.email, :subject => "Welcome to MySite")
  end

end