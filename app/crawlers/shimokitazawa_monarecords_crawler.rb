class ShimokitazawaMonarecordsCrawler < BaseCrawler
  CALENDAR_PATH = '/live'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢mona records')
  end

  def execute!
    @term.times do |i|
      month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + '/' + current_year_str + '/' + month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  def format(doc:)
    doc.css('.live-menu-box').each_with_object([]) do |li_element, events|
      event = OpenStruct.new(
        title: li_element.css('.live-title-monthly').text,
        date: Date.parse li_element.css('.live-date').text,
        act: li_element.css('.live-monthly p')[1]
                       .text
                       .gsub(/【出演】/,'')
                       .split(' / '),
        info: li_element.css('.live-monthly p')[2..].text.gsub(/[\r\n\t]/, '')
      events << event
    end
  end
end
