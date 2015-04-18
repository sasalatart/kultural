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
  belongs_to :rateable, polymorphic: true

  validates :value, presence: true,
                    numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 10 }

  validates :rateable_id, presence: true
  validates :rateable_type, presence: true
end
