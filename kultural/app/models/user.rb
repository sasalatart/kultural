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
  has_many :groups, through: :group_memberships
  has_many :group_memberships
  has_many :events, as: :owner
end
