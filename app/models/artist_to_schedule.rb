# == Schema Information
#
# Table name: artist_to_schedules
#
#  id          :integer          not null, primary key
#  artist_id   :integer          not null
#  schedule_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArtistToSchedule < ApplicationRecord
  belongs_to :artist, class_name: '::Artist'
  belongs_to :schedule, class_name: '::Schedule'
end
