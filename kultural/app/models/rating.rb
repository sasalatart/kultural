class Rating < ActiveRecord::Base
  validates :value, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  belongs_to :rateable, polymorphic: true
end
