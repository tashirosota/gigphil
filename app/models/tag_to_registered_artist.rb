# == Schema Information
#
# Table name: tag_to_registered_artists
#
#  id                       :bigint           not null, primary key
#  registered_artist_id     :bigint           not null
#  registered_artist_tag_id :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class TagToRegisteredArtist < ApplicationRecord
  belongs_to :tag
  belongs_to :registerd_artist
end
