class ShimokitazawaDaisyBarCrawler < BaseCrawler
  CALENDAR_PATH = '/events/event/on'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢DaisyBar')
  end

  def execute!
    @term.times do |i|
      set_month_instanse(i)
      request_url = @bar.hp + CALENDAR_PATH + '/' + current_year_str + '/' + @month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc:)
      end
    end
  end

  private

  def format(doc:)
    doc.css('.single-article').each_with_object([]) do |li_element, events|
      event = OpenStruct.new(
        title: li_element.css('.h4.strong').text,
        date: Date.parse(li_element.css('.single-date').text.gsub(/\(.+\) /, '')),
        act: li_element.css('.artist.strong')
                       .text
                       .gsub(/【ONE MAN】|【TWO MAN】|　…and more!!/, '')
                       .split('／'),
        info: li_element.css('.liveinfo').text
      )
      events << event
    end
  end
end
