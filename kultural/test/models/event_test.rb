# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  date        :datetime
#  price       :float
#  place_id    :integer
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
