class UserMailer < ApplicationMailer

  def signup_confirmation(user)
    @user = user

    mail to: @user.mail, subject: 'Welcome to kultur.al!'
  end

  def account_edit(user)
    @user = user
    @gender = 'male'
    @gender = 'female' unless @user.male?

    mail to: @user.mail, subject: 'Your account has been edited'
  end

  def password_edit(user)
    @user = user

    mail to: @user.mail, subject: 'Your password has been edited'
  end

  def new_follower(user, follower)
    @user = user
    @follower = follower

    if @user.followers.count == 1
      @msg = "We are glad to tell you that you have your first follower, whose
              name is #{@follower.name}"
    else
      @msg = "#{@follower.name} is now following you. You currently have
              #{@user.followers.count} followers."
    end

    mail to: @user.mail, subject: "#{@follower.name} is now following you"
  end

  def account_delete(user)
    @user = user

    mail to: @user.mail, subject: 'Your account has been deleted'
  end
end
