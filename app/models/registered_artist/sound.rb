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
  belongs_to :registerd_artist, class_name: 'RegisteredArtist'
end
