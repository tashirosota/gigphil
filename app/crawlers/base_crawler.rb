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
        schedules.each do |event|
          create_or_update_schedule_by!(bar: music_bar, event: event)
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

    def create_or_update_schedule_by!(bar:, event:)
      schedule = bar
                .schedules
                .find_or_initialize_by(event_date: event.date.all_day, title: event.title)

      schedule.update!(
        event_date: event.date,
        open: event.open,
        start: event.start,
        adv: event.adv&.to_i,
        door: event.adv&.to_i,
      )
    end

    # TODO: 別classに切り出す?
    def trim_meta_chars(char)
      char.gsub(/\t+|\n+|\r+/, '')
    end
  end
end

# NOTICE: クローリング結果を返す `subclass#format` の返り値 (OpenStruct)
# {
#   name: '大塚Deepa',
#   schedules: [
#     {
#       title: String,
#       event_date: DateTime,
#       adv: Integer (allow nil),
#       door: Integer (allow nil),
#       open: DateTime (allow nil),
#       start: DateTime (allow nil),
#       act: [String, String],
#       info: String,
#     },
#     {
#       title: String,
#       event_date: DateTime,
#       adv: Integer (allow nil),
#       door: Integer (allow nil),
#       open: DateTime (allow nil),
#       start: DateTime (allow nil),
#       act: [String, String],
#       info: String,
#     },
#   ]
# }
