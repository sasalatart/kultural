require 'spec_helper'
require 'rails_helper'

describe 'Authentication' do
  subject { page }

  before {
    @user = User.create(name: 'Jaime Castro R',
                        password: 'macoy123',
                        password_confirmation: 'macoy123',
                        mail: 'jecastro1@uc.cl',
                        phone: 123456789,
                        birthday: Date.strptime('31/12/1994', '%d/%m/%Y'),
                        male: true)
  }

  describe 'login' do
    before { visit login_path }

    describe 'with invalid credentials' do
      # fill_in 'session_mail',     with: @user.mail
      # fill_in 'session_password', with: 'invalidpassword'
      before { click_button 'login-submit' }

      it { should have_selector('div', id: 'alert') }
      it { should have_selector('form', id: 'login-form') }
    end

    describe 'with valid credentials' do
      # fill_in 'session_mail',     with: @user.mail
      # fill_in 'session_password', with: @user.password
      before { click_button 'login-submit' }

      it { should have_selector('div', id: 'notice') }
      it { should have_selector('div', id: 'user-info') }
    end
  end
end