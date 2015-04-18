# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ActiveRecord::Base
  has_many :users, through: :groups_users
  has_many :groups_users
  has_many :events, as: :owner

  validates :name,  presence: true,
                    length: { minimum: 5, maximum: 50 },
                    allow_blank: true

  validates :description, presence: true,
                          length: { maximum: 1000 },
                          allow_blank: true
end
