# [usage]
# class ExampleCrawler << BaseCrawler
# ExampleCrawler.execute!!
class BaseCrawler
  class << self 
    def execute!
      new_schedule, exist_schedule = divide_by_new_and_existing crawlering
      update_schedules! new_schedule
      insert_schedules! new_schedule!
    end
  
    private
  
    def divide_by_new_and_existing(schedules)
      [new_schedule, exist_schedule]
    end
  
    def crawlering
      raise 'Must implement #crawlering'
    end
  
    def update_schedules!(schedules)
      
    end
  
    def insert_schedules!(schedules)
      
    end
  end
end