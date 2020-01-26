# == Schema Information
#
# Table name: artist_to_schedules
#
#  id          :bigint           not null, primary key
#  artist_id   :bigint           not null
#  schedule_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArtistToSchedule < ApplicationRecord
  belongs_to :artist, class_name: '::Artist'
  belongs_to :schedule, class_name: '::Schedule'
end
