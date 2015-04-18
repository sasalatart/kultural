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
end
