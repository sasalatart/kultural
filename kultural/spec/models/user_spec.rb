require 'spec_helper'
require 'rails_helper'

describe User do

  before do

    def user_creator(name: 'Jaime Castro',
                     password: 'asdfgh',
                     password_confirmation: 'asdfgh',
                     mail: 'asdfgh@uc.cl',
                     phone: 12345678,
                     birthday: Date.today,
                     male: true)

      User.create(name: name,
                  password: password,
                  password_confirmation: password_confirmation,
                  mail: mail,
                  phone: phone,
                  birthday: birthday,
                  male: male)

    end
  end

  describe 'Try to create' do

    describe 'with name problems' do

      describe 'when name is too short (less than 5)' do
        it 'should not be valid' do
          user = user_creator(name: 'Pepe')
          expect(user).not_to be_valid
        end
      end

      describe 'when name is too long (more than 50)' do
        it 'should not be valid' do
          user = user_creator(name: 'P' * 51)
          expect(user).not_to be_valid
        end
      end

    end

    describe 'with password problems' do

      describe 'when password_confirmation is wrong' do
        it 'should not be valid' do
          user = user_creator(password_confirmation: 'auihweui')
          expect(user).not_to be_valid
        end
      end

      describe 'when password is too short (less than 6)' do
        it 'should not be valid' do
          pass = 'asdfg'
          user = user_creator(password: pass, password_confirmation: pass)
          expect(user).not_to be_valid
        end
      end

    end

    describe 'with mail problems' do

      describe 'when email is not valid' do
        it 'should not be valid' do
          user = user_creator(mail: 'zombiez@uc')
          expect(user).not_to be_valid
        end
      end

      describe 'when email is too large (more than 50)' do
        it 'should not be valid' do
          mail = 'g' * 45 << '@uc.cl'
          user = user_creator(mail: mail)
          expect(user).not_to be_valid
        end
      end

    end

    # Any value casts to 'false'
    # In Rails 5 this behaviour will change to 'true'
    describe 'when male is anything but true or false' do
      it 'should not be valid' do
        user = user_creator(male: 'should be dancing')
        expect(user).not_to be_valid
      end
    end

    describe 'with phone number problems' do

      describe 'when phone number is too short (less than 5)' do
        it 'should not be valid' do
          user = user_creator(phone: 1234)
          expect(user).not_to be_valid
        end
      end

      describe 'when phone number is too large (more than 15)' do
        it 'should not be valid' do
          user = user_creator(phone: 1234567890123456)
          expect(user).not_to be_valid
        end
      end

    end

    describe 'with birthday problems' do

      describe 'when birthday is not valid' do
        it 'should not be valid' do
          user = user_creator(birthday: 'jajaja')
          expect(user).not_to be_valid
        end
      end

      describe 'when birthday is in the future' do
        it 'should not be valid' do
          user = user_creator(birthday: Date.today + 2)
          expect(user).not_to be_valid
        end
      end

    end

    describe 'when no data is provided' do
      it 'should not be valid' do
        user = User.new
        expect(user).not_to be_valid
      end
    end

    describe 'when all seems to be correct' do
      it 'should be valid' do
        user = user_creator
        expect(user).to be_valid
      end
    end
  end

end