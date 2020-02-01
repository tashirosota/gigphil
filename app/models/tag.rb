# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  # タグなんだから短くしなさい
  validates :name, uniqueness: true, length: { maximum: 10 }
end
