class OtsukaDeepaCrawler < BaseCrawler
  CALENDAR_PATH = '/schedule/calendar'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '大塚Deepa')
  end

  def execute!
    @term.times do |time|
      save_crawling_result(url: request_url(time), parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  def request_url(time)
    month = (now.month + time).to_s.rjust(2, '0')
    @bar.hp + CALENDAR_PATH + '/' + current_year + '/' + month
  end

  # rubocop:disable all
  def format(doc:)
    doc.css('.scheduleList li').each_with_object([]) do |li_element, events|
      event = OpenStruct.new(
        title: li_element.css('h1').text,
        date: Date.parse(li_element.css('.day').text.gsub(/\(.+\)/, '')),
        adv: nil,
        door: nil,
        open: nil,
        start: nil,
        act: trim_meta_chars(li_element.css('.act').text.gsub(/\[ACT\]|Photographer：/, '')).split(%r{\s?/\s?}),
        info: li_element.css('.btnStyle01').first.attributes['href'].value
      )
      events << event
    end
  end
  # rubocop:enable all
end