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

class Group < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :admins, ->{ where memberships: { is_admin: true } }, through: :memberships, class_name: 'User', source: 'user'
  
  has_many :events, as: :owner
  has_many :places, as: :owner

  validates :name,  presence: true,
                    length: { minimum: 5, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }

end
