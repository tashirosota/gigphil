class OtsukaDeepaCrawler < BaseCrawler
  CALENDAR_PATH = '/events/event/on'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢DaisyBar')
  end

  def execute!
    @term.times do |i|
      month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + '/' + current_year + '/' + month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  def format(doc:)
    # TODO
  end
end
