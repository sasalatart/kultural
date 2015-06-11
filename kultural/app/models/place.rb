# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  lat         :float
#  lon         :float
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  address     :string
#

class Place < ActiveRecord::Base
  # Esto en vez de has_many
  include PgSearch
  pg_search_scope :search, against: :name,
                  using: {tsearch: {prefix: true}}

  #Geolocation
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode

  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :fans, class_name: 'User', foreign_key: 'user_id'
  has_many :events, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :name,  presence: true,
                    length: { minimum: 5, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }

  validates :address, presence: true
  validates :owner_id, presence: true
  validates :owner_type, presence: true
end
