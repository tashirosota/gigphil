# [usage]
# class ExampleCrawler << BaseCrawler
# ExampleCrawler.execute!!
class BaseCrawler
  class << self
    def execute!
      schedules = crawlering
      new_schedule, exist_schedule = divide_by_new_and_existing schedules
      update_schedules! schedules.name exist_schedule
      insert_schedules! schedules.name, new_schedule
    end

    private

    def divide_by_new_and_existing(_schedules)
      [new_schedule, exist_schedule]
    end

    def crawlering
      raise 'Must implement #crawlering'
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
