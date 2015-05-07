# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  mail            :string
#  phone           :integer
#  birthday        :date
#  male            :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  include PgSearch
  multisearchable against: :name
  has_many :groups, through: :memberships
  has_many :memberships
  has_many :events, as: :owner
  has_and_belongs_to_many :places
  has_many :comments
  has_many :reports
  has_many :ratings

  before_save { |user| user.mail = user.mail.downcase }

  validates :name,  presence: true,
                    length: { minimum: 5, maximum: 50 }

  has_secure_password
  validates :password,  length: { minimum: 6 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :mail,  presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :phone, presence: true,
                    length: { minimum: 5, maximum: 15 }

  validates :birthday, presence: true
end
