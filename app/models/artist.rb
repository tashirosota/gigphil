# == Schema Information
#
# Table name: artists
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  registered_artist_id :integer
#

class Artist < ApplicationRecord
  has_many :artist_to_schedules, class_name: '::ArtistToSchedule', dependent: :destroy
  has_many :schedules, through: :artist_to_schedules
  belongs_to :registered_artist, class_name: 'RegisteredArtist', optional: true

  validates :name, presence: true, uniqueness: true
end
