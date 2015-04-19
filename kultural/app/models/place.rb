# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  x           :float
#  y           :float
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Place < ActiveRecord::Base
  # Esto en vez de has_many
  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :users
  has_many :events
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable
  has_many :reports, as: :reportable

  validates :name,  presence: true,
                    length: { minimum: 5, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }

  validates :x, presence: true
  validates :y, presence: true
  validates :owner_id, presence: true
  validates :owner_type, presence: true
end
