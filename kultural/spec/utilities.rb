def user_creator(name: 'Jaime Castro',
                 password: 'foobar', password_confirmation: 'foobar',
                 mail: 'foobar@baz.cl', phone: 12345678,
                 birthday: Date.today, male: true)

  User.create(name: name,
              password: password, password_confirmation: password_confirmation,
              mail: mail, phone: phone,
              birthday: birthday, male: male)
end

def login(mail, password)
  fill_in 'session_mail',     with: mail
  fill_in 'session_password', with: password
  click_button 'login-submit'
end
