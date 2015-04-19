# == Schema Information
#
# Table name: groups_users
#
#  is_admin   :boolean
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates_inclusion_of :is_admin, in: [true, false]
  validates :user_id, presence: true
  validates :group_id, presence: true
end
