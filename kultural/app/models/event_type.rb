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
  validates :name, presence: true,
                   length: { minimum: 5, maximum: 50 }

  validates :examples, presence: true,
                       length: { minimum: 5, maximum: 50 }

end
