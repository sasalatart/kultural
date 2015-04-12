# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  date        :datetime
#  price       :float
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :event_types
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable
end
