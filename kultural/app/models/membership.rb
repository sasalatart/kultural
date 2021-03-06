# == Schema Information
#
# Table name: memberships
#
#  is_admin   :boolean
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  id         :integer          not null, primary key
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates_inclusion_of :is_admin, in: [true, false]
  validates :user_id, presence: true, uniqueness: {scope: :group_id}
  validates :group_id, presence: true
end
