# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  genuine         :boolean
#  user_id         :integer
#  reportable_id   :integer
#  reportable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates :user_id, presence: true
  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
end
