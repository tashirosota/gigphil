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
  def self.names
    all.pluck(:name)
  end

  def self.to_hash
    all.map { |tag| { id: tag.id, name: tag.name } }
  end
end
