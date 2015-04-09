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

require 'test_helper'

class GroupMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
