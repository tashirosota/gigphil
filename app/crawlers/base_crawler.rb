# [usage]
# class ExampleCrawler << BaseCrawler
# ExampleCrawler.execute!

require 'open-uri'

class BaseCrawler
  class << self
    def save_crawling_result(url:, parser:)
      doc = parser.call(url)
      events = yield(doc)
      new_schedule, exist_schedule = divide_by_new_and_existing(events)
      return # TODO: following lines are to be implemented
      update_schedules! schedules.name exist_schedule
      insert_schedules! schedules.name, new_schedule
    end

    def execute!
      raise NotImplementedError, 'Implement #execute! to the subclass'
    end

    private

    def now
      @now ||= Time.zone.now
    end

    def nokogiri
      proc { |url| Nokogiri::HTML(open(url)) }
    end

    def divide_by_new_and_existing(events)
      [new_schedule, exist_schedule]
    end

    def update_schedules!(name, schedules)
      return unless hako = MusicBar.find_by(title: name)
      schedules.each do |schedule|
        hako.schedules.find(date: schedule.date).update! schedule
      end
    end

    def insert_schedules!(name, schedules)
      return unless hako = MusicBar.find_by(title: name)
      hako.schedule.create_all! schedules
    end

    def trim_meta_chars(char)
      char.gsub(/\t+|\n+|\r+/, '')
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
