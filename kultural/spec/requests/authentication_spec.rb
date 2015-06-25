require 'spec_helper'
require 'rails_helper'

describe 'Authentication' do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe 'login' do
    describe 'with invalid credentials' do
      before do
        visit login_path
        login(user.mail, 'invalidpassword')
      end

      it { should have_content('Error') }
      it { should have_content('LOGIN') }
    end

    describe 'with valid credentials' do
      before do
        visit login_path
        login(user.mail, user.password)
      end

      it { should have_content('Welcome') }
      it { should have_content(user.name) }
    end
  end
end
