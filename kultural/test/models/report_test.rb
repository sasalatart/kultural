# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  reportable_id   :integer
#  reportable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
