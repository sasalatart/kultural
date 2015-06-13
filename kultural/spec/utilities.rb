def login(mail, password)
  fill_in 'session_mail',     with: mail
  fill_in 'session_password', with: password
  click_button 'login-submit'
end
