class ShibuyaCrawlCrawler < BaseCrawler
  CALENDAR_PATH = '/crawl/event-monthly/?cmonth='
  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '渋谷CRAWL')
  end

  def execute!
    @term.times do |i|
      @month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + current_year_str + @month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.single-event.schedule.seperator').each_with_object([]) do |li_element, events|
      day = li_element.css('.date').text.reverse.match(/\d+/).to_s.reverse.to_i # 後方からmatch探したかった
      event = OpenStruct.new(
        title: li_element.css('.event-title.title').text.gsub(/[\r\n\t]/, '').gsub(' ', ''),
        date: Date.new(current_year_str.to_i, @month.to_i, day),
        act: li_element.css('.content-text p').text.gsub(/[\r\n\t]/, '').split(' ') + [li_element.css('.content-text p').text.gsub(/[\r\n\t]/, '')],
        info: li_element.css('ul').text.gsub(/[\r\n\t]/, '').gsub(' ', '')
      )
      pp event
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
