class UserMailer < ApplicationMailer
  default from: 'jamesg@jamesg.app'

  def welcome_email
    @user = params[:user]
    @url  = 'https://internnews.vercel.com/login'
    mail(to: @user.email, subject: 'Welcome to Intern News')
  end
end
