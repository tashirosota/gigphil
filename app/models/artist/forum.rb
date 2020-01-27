# == Schema Information
#
# Table name: artist_forums
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Artist::Forum < ApplicationRecord
end
