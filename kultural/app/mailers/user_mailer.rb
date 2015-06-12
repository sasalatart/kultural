class UserMailer < ApplicationMailer

  def signup_confirmation(user)
    @user = user

    mail to: @user.mail, subject: 'Welcome to kultur.al!'
  end

  def account_edit(user)
    @user = user

    mail to: @user.mail, subject: 'Your account has been edited'
  end

  def password_edit(user)
    @user = user

    mail to: @user.mail, subject: 'Your password has been edited'
  end

  def new_follower(user, follower)
    @user = user
    @follower = follower

    mail to: @user.mail, subject: "#{@follower.name} is now following you on kultur.al"
  end

  def account_delete(user)
    @user = user

    mail to: @user.mail, subject: "Your account has been deleted"
  end
end
