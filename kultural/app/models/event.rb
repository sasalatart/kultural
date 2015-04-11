class Event < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :event_types
  has_many :ratings, as: :rateable
end
