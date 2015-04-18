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
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable
  has_many :reports, as: :reportable
end
