# == Schema Information
#
# Table name: favorite_artists
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  user_id              :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class FavoriteArtist < ApplicationRecord
  belongs_to :user
  belongs_to :artist, class_name: 'RegisteredArtist'
end
