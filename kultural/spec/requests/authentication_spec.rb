require 'spec_helper'
require 'rails_helper'

describe 'Authentication' do
  subject { page }

  before {
    @user = User.create(name: 'Napoleon Bonaparte',
                              password: 'Austerlitz',
                              password_confirmation: 'Austerlitz',
                              mail: 'napoleon@uc.cl',
                              phone: 17691821,
                              birthday: Date.strptime('15/08/1769', '%d/%m/%Y'),
                              male: true)
  }

  describe 'login' do
    before { visit login_path }

    describe 'with invalid credentials' do
      it 'should fail' do
        fill_in 'session_mail',     with: @user.mail
        fill_in 'session_password', with: 'invalidpassword'
        click_button 'login-submit'

        should have_content('Error')
        should have_content('LOGIN')
      end
    end

    describe 'with valid credentials' do
      it 'should succeed' do
        fill_in 'session_mail',     with: @user.mail
        fill_in 'session_password', with: @user.password
        click_button 'login-submit'

        should have_content('Welcome')
        should have_content(@username)
      end
    end
  end
end