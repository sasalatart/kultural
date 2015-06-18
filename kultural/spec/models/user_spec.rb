# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  password_digest     :string
#  mail                :string
#  phone               :integer
#  birthday            :date
#  male                :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'spec_helper'
require 'rails_helper'

describe User do
  before do
    @user1 = user_creator(name: 'Esteban Retamal', mail: 'esretamal@uc.cl')
    @user2 = user_creator(name: 'Gema Rubí', mail: 'gemarubi@uc.cl')
  end

  describe 'Try to create' do
    describe 'when no data is provided' do
      it 'should not be valid' do
        user = User.new
        expect(user).not_to be_valid
      end
    end

    describe 'with name problems' do
      describe 'when name is too short' do
        it 'should not be valid' do
          user = user_creator(name: 'Pepe')
          expect(user).not_to be_valid
        end
      end

      describe 'when name is too long' do
        it 'should not be valid' do
          user = user_creator(name: 'P' * 51)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'with password problems' do
      describe 'when password_confirmation is wrong' do
        it 'should not be valid' do
          user = user_creator(password_confirmation: 'wrongpass')
          expect(user).not_to be_valid
        end
      end

      describe 'when password is too short' do
        it 'should not be valid' do
          pass = 'foo'
          user = user_creator(password: pass, password_confirmation: pass)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'with mail problems' do
      describe 'when email does not follow the format' do
        it 'should not be valid' do
          user = user_creator(mail: 'zombiez@uc')
          expect(user).not_to be_valid
        end
      end

      describe 'when email is too long' do
        it 'should not be valid' do
          mail = 'g' * 45 << '@uc.cl'
          user = user_creator(mail: mail)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'with phone number problems' do
      describe 'when phone number is too short' do
        it 'should not be valid' do
          user = user_creator(phone: 1234)
          expect(user).not_to be_valid
        end
      end

      describe 'when phone number is too long' do
        it 'should not be valid' do
          user = user_creator(phone: 1234567890123456)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'with birthday problems' do
      describe 'when birthday is not a date' do
        it 'should not be valid' do
          user = user_creator(birthday: 'foobar')
          expect(user).not_to be_valid
        end
      end

      describe 'when birthday is in the future' do
        it 'should not be valid' do
          user = user_creator(birthday: Date.today + 1)
          expect(user).not_to be_valid
        end
      end
    end

    describe 'when email already exists' do
      it 'should fail' do
        user1 = user_creator
        user2 = user_creator(name: 'Sebastián Salata')
        expect(user1).to be_valid
        expect(user2).not_to be_valid
      end
    end

    describe 'when all seems to be correct' do
      it 'should be valid' do
        expect(@user1).to be_valid
      end
    end
  end

  describe 'Following people' do
    describe 'when a user tries to follow another user' do
      it 'should increase its following count by 1' do
        expect { @user1.follow(@user2) }.to change { @user1.following.count }.by(1)
      end
    end

    describe 'when a user tries to follow another user twice' do
      it 'should fail' do
        @user1.follow(@user2)
        expect { @user1.follow(@user2) }.not_to change { @user1.following.count }
      end
    end
  end
end
