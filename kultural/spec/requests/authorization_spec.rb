require 'spec_helper'
require 'rails_helper'

describe 'Authorization' do
  subject { page }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user, mail: 'another@mail.com') }

  describe 'Try to edit a user' do
    describe 'when signed in' do
      before do
        visit login_path
        login(user1.mail, user1.password)
      end

      describe 'and visiting my own edit path' do
        before { visit edit_user_path user1 }
        it { should_not have_content('Error') }
      end

      describe 'and visiting an edit path I do not own' do
        before { visit edit_user_path user2 }
        it { should have_content('Error') }
      end
    end

    describe 'when not signed in' do
      before { visit edit_user_path user1 }
      it { should have_content('Error') }
      before { visit edit_user_path user2 }
      it { should have_content('Error') }
    end
  end
end
