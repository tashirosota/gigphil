class OtsukaDeepaCrawler < BaseCrawler
  CALENDAR_PATH = '/schedule/calendar'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '大塚Deepa')
  end

  def execute!
    @term.times do |i|
      set_month_instanse(i)
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  def request_url
    @bar.hp + CALENDAR_PATH + '/' + current_year_str + '/' + @month
  end

  # rubocop:disable all
  def format(doc:)
    doc.css('.scheduleList li').each_with_object([]) do |li_element, events|
      title = li_element.css('h1').text 
      next if title == 'HALL RENTAL' || title == 'BOOKING'
      event = OpenStruct.new(
        title: title,
        date: Date.parse(li_element.css('.day').text.gsub(/\(.+\)/, '')),
        act: trim_meta_chars(li_element.css('.act').text.gsub(/\[ACT\]|Photographer：/, '')).split(%r{\s?/\s?}),
        info: li_element.css('.btnStyle01').first.attributes['href'].value
      )
      events << event
    end
  end
  # rubocop:enable all
end
