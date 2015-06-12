class UserMailer < ApplicationMailer

  def signup_confirmation(user)
    @user = user

    mail to: @user.mail, subject: 'Welcome to kultur.al!'
  end

  def account_edit
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
