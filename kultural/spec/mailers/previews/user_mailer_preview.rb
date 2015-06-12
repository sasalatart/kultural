# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_confirmation
  def signup_confirmation
    UserMailer.signup_confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_edit
  def account_edit
    UserMailer.account_edit
  end

end
