require 'spec_helper'
require 'rails_helper'

describe Group do

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

    @user1 = user_creator(name: 'Esteban Retamal',
                          mail: 'esretamal@uc.cl')
    @group1 = @user1.create_group(name: 'Illuminatis', description: 'Uníos')

  end

  describe 'when data creation is not valid' do

    describe 'no data is provided' do
      it 'should be invalid' do
        group = Group.new
        group.save
        expect(group).not_to be_valid
      end
    end

    describe 'no name is provided' do
      it 'should be invalid' do
        group = Group.create(description: 'Uníos')
        expect(group).not_to be_valid
      end
    end

    describe 'no description is provided' do
      it 'should be invalid' do
        group = Group.create(name: 'Illuminatis')
        expect(group).not_to be_valid
      end
    end

    describe 'name is too short (less than 5)' do
      it 'should be invalid' do
        group = Group.create(name: 'ABCD', description: 'Uníos')
        expect(group).not_to be_valid
      end
    end

    describe 'name is too long (more than 50)' do
      it 'should be invalid' do
        group = Group.create(name: 'A' * 51, description: 'Uníos')
        expect(group).not_to be_valid
      end
    end

    describe 'description is too long (more than 1000)' do
      it 'should be invalid' do
        group = Group.create(name: 'Illuminatis', description: 'asd' * 334)
        expect(group).not_to be_valid
      end
    end

  end


  describe 'when a user creates a group' do
    it 'should be admin' do
      expect(@user1.is_group_admin?(@group1)).to be_truthy
    end
  end

  describe 'when a admin leaves a group' do
    it 'should not change' do
      expect {@user1.leave_group(@group1)}.not_to change{@user1.groups_where_is_admin.count}
    end
  end

  describe 'when a user join another group' do
    it 'should change groups.count' do
      user2 = user_creator(name: 'Marcelo',
                           mail: 'illuminati@uc.cl')
      expect {user2.join_group(@group1)}.to change{user2.groups.count}.by(1)
    end
  end

end