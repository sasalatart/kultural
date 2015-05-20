require 'spec_helper'
require 'rails_helper'

describe 'Authorization' do
  before do
    @user1 = User.create(name: 'Napoleon Bonaparte',
                         password: 'Austerlitz',
                         password_confirmation: 'Austerlitz',
                         mail: 'napoleon@uc.cl',
                         phone: 17691821,
                         birthday: Date.strptime('15/08/1769', '%d/%m/%Y'),
                         male: true)

    @user2 = User.create(name: 'Josephine',
                         password: 'Napoleon',
                         password_confirmation: 'Napoleon',
                         mail: 'josephine@uc.cl',
                         phone: 17631814,
                         birthday: Date.strptime('23/06/1763', '%d/%m/%Y'),
                         male: false)
  end

  describe 'Try to edit a user' do
    describe 'when signed in' do
      before do
        visit login_path
        fill_in 'session_mail',     with: @user1.mail
        fill_in 'session_password', with: @user1.password
        click_button 'login-submit'
      end

      describe 'and visiting my own edit path' do
        it 'should not fail' do
          visit edit_user_path @user1
          expect(page).not_to have_content('Error')
        end
      end

      describe 'and visiting an edit path I do not own' do
        it 'should fail' do
          visit edit_user_path @user2
          expect(page).to have_content('Error')
        end
      end
    end

    describe 'when not signed in' do
      it 'should fail' do
        visit edit_user_path @user1
        expect(page).to have_content('Error')
        visit edit_user_path @user2
        expect(page).to have_content('Error')
      end
    end
  end
end