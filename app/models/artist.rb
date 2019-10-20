# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artist < ApplicationRecord
  has_many :artist_to_schedules, class_name: '::ArtistToSchedule', dependent: :destroy
  has_many :schedules, through: :artist_to_schedules

  validates :name, presence: true, uniqueness: true
end
