# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :string
#  description          :text
#  date                 :datetime
#  price                :float
#  place_id             :integer
#  owner_id             :integer
#  owner_type           :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Event < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: :name,
                  using: { tsearch: { prefix: true } }

  has_attached_file :picture,
                    default_url: 'events/default.png',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/extras/dropbox.yml'),
                    dropbox_options: { path: proc { |style| "events/#{id}/#{picture.original_filename}" } },
                    styles: {
                      thumb: '100x100#',
                      normal: '300x200>'
                    }

  belongs_to :owner, polymorphic: true
  belongs_to :place
  has_and_belongs_to_many :event_types
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :name, presence: true,
                   length: { minimum: 5, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }
  validates :date, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :place, presence: true
  validates :owner_id, presence: true
  validates :owner_type, presence: true
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  # Attendance
  has_many :attendances, dependent: :destroy
  has_many :attendants, class_name: 'User', through: :attendances, source: 'user'
  def get_picture(size)
    picture.url(size)
  end
end
