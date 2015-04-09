# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  is_admin   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
