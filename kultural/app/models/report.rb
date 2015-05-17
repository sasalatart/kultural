# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  reportable_id   :integer
#  reportable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :user_id, presence: true,
                      uniqueness: { scope: [ :reportable_id, :reportable_type ] }
end
