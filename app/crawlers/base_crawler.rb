# [usage]
# class ExampleCrawler << BaseCrawler
# ExampleCrawler.execute!

require 'open-uri'

class BaseCrawler
  class << self
    def save_crawling_result(url:, parser:)
      doc = parser.call(url)
      events = yield(doc)

      music_bar = events[:music_bar]
      schedules = events[:schedules]
      ActiveRecord::Base.transaction do
        schedules.map do |event|
          find_or_create_schedule_by(bar: music_bar, event: event)
        end
      end
    end

    def execute!
      raise NotImplementedError, 'Implement .execute! to the subclass'
    end

    private

    def now
      @now ||= Time.zone.now
    end

    def nokogiri
      proc { |url| Nokogiri::HTML(open(url)) }
    end

    def find_or_create_schedule_by(bar:, event:)
      event_date = Date.parse(event.date).all_day

      # FIXME: title カラムを追加したらevent_dateとtitleでfind_or_create_by!
      bar.schedules.find_or_create_by!(event_date: event_date, info: event.title) do |schedule|
        schedule.assign_attributes(
          event_date: try_parse_date(event.date).to_datetime,
          open: try_parse_datetime(event.open),
          start: try_parse_datetime(event.start),
          adv: event.adv&.to_i,
          door: event.adv&.to_i,
          info: event.title,
        )
      end
    end

    # TODO: 別classに切り出す?
    def trim_meta_chars(char)
      char.gsub(/\t+|\n+|\r+/, '')
    end

    def try_parse_date(date_string)
      date_string.nil? ? nil : Date.parse(date_string)
    end

    def try_parse_datetime(datetime_string)
      datetime_string.nil? ? nil : DateTime.parse(datetime_string)
    end
  end
end

# crawleringの返り値(OpenStruct)
# {
#   name: '大塚Deepa',
#   schedules: [
#     {
#       title: String,
#       date: String,
#       adv: String?,
#       door: String?,
#       open: Time?,
#       start: Time?,
#       act: [String, String],
#       info: String?
#     },
#     {
#       title: String,
#       date: String,
#       adv: String?,
#       door: String?,
#       open: Time?,
#       start: Time?,
#       act: [String, String],
#       info: String?
#     }
#   ]
# }
