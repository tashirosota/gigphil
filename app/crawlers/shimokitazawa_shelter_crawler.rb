class ShimokitazawaShelterCrawler < BaseCrawler
  CALENDAR_PATH = '/schedule/shelter/date'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢SHELTER')
  end

  def execute!
    @term.times do |i|
      @month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + '/' + current_year_str + '/' + @month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.timetable tr').each_with_object([]) do |li_element, events|
      day = li_element.css('.day').text.match(/\d+/).to_s.to_i
      info = li_element.css('.time_text').text.gsub(/[\r\n\t]/, '')
      ticket = li_element.css('.ticket').text.gsub(/[\r\n\t]/, '')
      event = OpenStruct.new(
        title: li_element.css('.event_box h3').text,
        date: Date.new(current_year_str.to_i, @month.to_i, day),
        act: li_element.css('.month_content').text.split("\n") - [''],
        info: info + ticket
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
