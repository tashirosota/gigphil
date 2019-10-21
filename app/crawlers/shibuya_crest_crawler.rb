class ShibuyaCrestCrawler < BaseCrawler
  CALENDAR_PATH = '/crawl/event-monthly/?cmonth='
  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '渋谷O-Crest')
  end

  def execute!
    @term.times do |i|
      @month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + "/?year-month=#{current_year_str}-#{@month}#schedule"
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.schedule-event.row').each_with_object([]) do |li_element, events|
      day = li_element.css('.schedule-date strong').text.to_i
      pp li_element.css('.schedule-time.d-flex a')
      event = OpenStruct.new(
        title: li_element.css('.schedule-details h4').text.gsub(/[\r\n\t]/, '').gsub(' ', ''),
        date: Date.new(current_year_str.to_i, @month.to_i, day),
        act: li_element.css('label span').map(&:text),
        info: ''
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
