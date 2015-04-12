# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  value         :integer
#  rateable_id   :integer
#  rateable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rating < ActiveRecord::Base
  validates :value, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  belongs_to :rateable, polymorphic: true
end
