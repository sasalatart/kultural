# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  password_digest     :string
#  mail                :string
#  phone               :string
#  birthday            :date
#  male                :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class User < ActiveRecord::Base
  include PgSearch

  has_attached_file :avatar,
                    default_url: 'placeholders/profile.png',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/extras/dropbox.yml'),
                    dropbox_options: { path: proc { |style| "avatars/#{id}/#{avatar.original_filename}" } },
                    styles: {
                      thumb: '100x100#',
                      square: '200x200#',
                      medium: '300x300>'
                    }

  pg_search_scope :search, against: :name, using: { tsearch: { prefix: true } }

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :groups_where_is_admin, ->{ where memberships: { is_admin: true} }, through: :memberships, class_name: 'Group', source: 'group'
  has_many :events, as: :owner, dependent: :destroy
  has_many :places, as: :owner, dependent: :destroy
  has_and_belongs_to_many :favourite_places, class_name: 'Place'
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :ratings, dependent: :destroy
  # Attendance
  has_many :attendances, dependent: :destroy
  has_many :events_to_attend, class_name: 'Event', through: :attendances, source: 'event'

  # Follow people
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  before_save { |user| user.mail = user.mail.downcase }

  validates :name, presence: true,
                   length: { minimum: 5, maximum: 50 }

  has_secure_password
  validates :password, length: { minimum: 6 }, if: :password_changed?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :mail,  presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :birthday, date_past_or_today: true
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Utility methods for follow system

  def follow(foo_user)
    active_relationships.create(followed_id: foo_user.id)
  end

  def unfollow(foo_user)
    active_relationships.find_by(followed_id: foo_user.id).destroy
  end

  def following?(foo_user)
    following.include?(foo_user)
  end

  def followed?(foo_user)
    followers.include?(foo_user)
  end

  def create_group(group_params)
    groups_where_is_admin.create(group_params)
  end

  def join_group(group)
    memberships.create(group_id: group.id, is_admin: false)
  end

  def leave_group(group)
    memberships.find_by(group_id: group.id).destroy
  end

  def belongs_to_group?(group)
    groups.include?(group)
  end

  def is_group_admin?(group)
    groups_where_is_admin.include?(group)
  end

  def get_avatar(size)
    avatar.url(size)
  end

  def get_phone
    return 'Not yet set' if phone.nil? or phone.blank?
    return phone
  end

  def get_birthday
    return 'Not yet set' if birthday.nil? or birthday.blank?
    return birthday
  end

  def get_gender
    if male.nil?  
      'Not yet set'
    else
      male ? 'Male' : 'Female'
    end
  end

  def password_changed?
    !@password.blank?
  end

  def attending?(event)
    events_to_attend.include? event
  end

  def followed_attending_to(event)
    f = []
    User.all.each do |u|
      if u.attending?(event) and self.following.include? u
        f.push(u)
      end
    end
    return f
  end
end
