# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ApplicationRecord
  has_many :artists, class_name: 'RegisteredArtist', dependent: :destroy
  validates :name, uniqueness: true
  def self.names
    all.pluck(:name)
  end

  def self.to_hash
    all.map { |area| { id: area.id, name: area.name } }
  end
end
