# == Schema Information
#
# Table name: registered_artist_tags
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  name                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class RegisteredArtist::Tag < ApplicationRecord
end
