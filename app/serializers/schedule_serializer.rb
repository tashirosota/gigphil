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
