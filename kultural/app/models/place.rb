# == Schema Information
#
# Table name: places
#
#  id                   :integer          not null, primary key
#  name                 :string
#  description          :text
#  lat                  :float
#  lon                  :float
#  owner_id             :integer
#  owner_type           :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  address              :string
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Place < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: :name,
                  using: {tsearch: {prefix: true}}

  has_attached_file :picture,
                    default_url: 'places/default.png',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/extras/dropbox.yml'),
                    dropbox_options: { path: proc { |style| "places/#{id}/#{picture.original_filename}" } },
                    styles: {
                      thumb: '100x100#',
                      normal: '300x200>'
                    }

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
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def get_picture(size)
    picture.url(size)
  end
end
