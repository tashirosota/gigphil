class ShinjukuNinespicesCrawler < BaseCrawler
  CALENDAR_PATH = '/schedule'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '新宿NINE SPICES')
  end

  def execute!
    @term.times do |i|
      set_month_instanse(i)
      request_url = @bar.hp + CALENDAR_PATH + "/?sch-year=#{current_year_str}&sch-mon=#{@month}"
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc:)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.event-cont-par').each_with_object([]) do |li_element, events|
      dates = li_element.css('p.event_date').text.split('.').map(&:to_i)
      event = OpenStruct.new(
        title: li_element.css('.event-title').map(&:text)[0],
        date: Date.new(current_year_str.to_i, dates[0], dates[1]),
        act: li_element.css('.actlist-name-p').map(&:text),
        info: li_element.css('.sch-center-wrap').text.gsub(/[\r\n\t]+/, ' ')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
