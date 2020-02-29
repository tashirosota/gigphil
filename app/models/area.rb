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
end