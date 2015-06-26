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

  has_attached_file :avatar,
                    default_url: 'placeholders/profile.png',
                    storage: :dropbox,
                    dropbox_credentials: Rails.root.join('config/extras/dropbox.yml'),
                    dropbox_options: { path: proc { |style| "groups/#{id}/#{avatar.original_filename}" } },
                    styles: {
                      thumb: '100x100#',
                      square: '200x200#',
                      medium: '300x300>'
                    }

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :admins, ->{ where memberships: { is_admin: true } }, through: :memberships, class_name: 'User', source: 'user'

  has_many :events, as: :owner, dependent: :destroy
  has_many :places, as: :owner, dependent: :destroy

  validates :name,  presence: true,
                    length: { minimum: 2, maximum: 50 }

  validates :description, presence: true,
                          length: { maximum: 1000 }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def get_avatar(size)
    avatar.url(size)
  end
end
