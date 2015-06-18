# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'
require 'rails_helper'

describe Group do
  before do
    @user1 = user_creator(name: 'Esteban Retamal', mail: 'esretamal@uc.cl')
    @group1 = @user1.create_group(name: 'Illuminatis', description: 'Uníos')
  end

  describe 'when no data is provided' do
    it 'should not be valid' do
      group = Group.new
      expect(group).not_to be_valid
    end
  end

  describe 'when no name is provided' do
    it 'should not be valid' do
      group = Group.new(description: 'Uníos')
      expect(group).not_to be_valid
    end
  end

  describe 'when no name is provided' do
    it 'should not be valid' do
      group = Group.new(name: 'Illuminatis')
      expect(group).not_to be_valid
    end
  end

  describe 'when name is too short' do
    it 'should not be valid' do
      group = Group.new(name: 'ABCD', description: 'Uníos')
      expect(group).not_to be_valid
    end
  end

  describe 'when name is too long' do
    it 'should not be valid' do
      group = Group.new(name: 'A' * 51, description: 'Uníos')
      expect(group).not_to be_valid
    end
  end

  describe 'when description is too long' do
    it 'should not be valid' do
      group = Group.new(name: 'Illuminatis', description: 'a' * 1001)
      expect(group).not_to be_valid
    end
  end

  describe 'when a user creates a group' do
    it 'should be admin' do
      expect(@user1.is_group_admin?(@group1)).to be_truthy
    end
  end

  describe 'when a user join another group' do
    it 'should change groups.count' do
      user2 = user_creator(name: 'Marcelo', mail: 'illuminati@uc.cl')
      expect { user2.join_group(@group1) }.to change{ user2.groups.count }.by(1)
    end
  end
end
