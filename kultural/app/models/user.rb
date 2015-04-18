# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  password   :string
#  mail       :string
#  phone      :integer
#  birthday   :date
#  male       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :groups, through: :groups_users
  has_many :groups_users
  has_many :events, as: :owner
  has_many :comments
  has_and_belongs_to_many :places
end
