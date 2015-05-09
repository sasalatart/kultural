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

class Event < ActiveRecord::Base
  include PgSearch
  #TODO: pg search: maybe add :description.
  #:if => !:finished? #only search for future events
  pg_search_scope :search, against: :name,
                  using: {tsearch: {prefix: true}}
                  
  belongs_to :owner, polymorphic: true
  belongs_to :place
  has_and_belongs_to_many :event_types
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable
  has_many :reports, as: :reportable

  validates :name, presence: true,
                   length: { minimum: 5, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }

  validates :date, presence: true
  validates :price, presence:true
  validates :owner_id, presence: true
  validates :owner_type, presence: true
end
