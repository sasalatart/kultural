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

describe User
