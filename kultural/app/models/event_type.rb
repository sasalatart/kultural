# == Schema Information
#
# Table name: event_types
#
#  id         :integer          not null, primary key
#  name       :string
#  examples   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventType < ActiveRecord::Base

  has_and_belongs_to_many :events

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 50 },
                   uniqueness: true, case_sensitive: false

  validates :examples, presence: true,
                       length: { minimum: 3, maximum: 50 }

end
