# == Schema Information
#
# Table name: registered_artist_sounds
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  title                :string           not null
#  url                  :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class RegisteredArtist::Sound < ApplicationRecord
  belongs_to :registered_artist, class_name: 'RegisteredArtist', inverse_of: :sounds, touch: true
  validates :url, format: /\A#{URI.regexp(%w(http https))}\z/
end
