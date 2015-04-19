# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true,
                      length: { maximum: 1500 }

  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
