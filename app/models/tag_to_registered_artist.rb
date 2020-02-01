# == Schema Information
#
# Table name: tag_to_registered_artists
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  tag_id               :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class TagToRegisteredArtist < ApplicationRecord
  belongs_to :tag
  belongs_to :registered_artist, class_name: 'RegisteredArtist'
end
