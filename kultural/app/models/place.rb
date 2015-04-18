class Place < ActiveRecord::Base
  # Esto en vez de has_many
  belongs_to :owner, polymorphic: true
  has_and_belongs_to_many :users
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable
  has_many :reports, as: :reportable
end
