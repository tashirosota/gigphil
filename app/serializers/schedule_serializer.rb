# == Schema Information
#
# Table name: schedules
#
#  id           :bigint           not null, primary key
#  music_bar_id :bigint           not null
#  title        :string           not null
#  event_date   :datetime         not null
#  info         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ScheduleSerializer
  include FastJsonapi::ObjectSerializer
  attributes \
    :id,
    :title,
    :event_date,
    :info,
    :artist_names,
    :music_bar_model
end
