class ScheduleSerializer
  include FastJsonapi::ObjectSerializer
  attributes \
    :id,
    :title,
    :event_date,
    :info,
    :artist_names,
    :music_bar_name,
    :music_bar_place,
    :music_bar_hp
end
