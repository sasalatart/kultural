# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  x           :float
#  y           :float
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
