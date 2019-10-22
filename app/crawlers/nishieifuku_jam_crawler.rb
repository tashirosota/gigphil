class NishieifukuJamCrawler < BaseCrawler
  CALENDAR_PATH = '/schedule'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '西永福JAM')
  end

  def execute!
    @term.times do |i|
      month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + "/?sch-year=#{current_year_str}&sch-mon=#{month}"
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.event-cont-par').each_with_object([]) do |li_element, events|
      dates = li_element.css('.event_date').text.split('.').map(&:to_i)
      event = OpenStruct.new(
        title: li_element.css('.event-title').text.gsub(/[\r\n\t]/, ''),
        date: Date.new(current_year_str.to_i, dates[0], dates[1]),
        act: li_element.css('.event-info p')[0]
                       .text
                       .split(' / '),
        info: li_element.css('.event-info p')[1..].text.gsub(/[\r\n\t]/, '')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
