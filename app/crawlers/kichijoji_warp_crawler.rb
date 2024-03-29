class KichijojiWarpCrawler < BaseCrawler
  CALENDAR_PATH = '/Schedules/calendarSchedules'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '吉祥寺Warp')
  end

  def execute!
    @term.times do |i|
      set_month_instanse(i)
      save_crawling_result(url: nil, parser: post_and_nokogiri) do |doc|
        format(doc:)
      end
    end
  end

  private

  def post_and_nokogiri
    res = Net::HTTP.post_form(
      URI.parse(@bar.hp + CALENDAR_PATH),
      year: current_year_str,
      month: @month,
      category_cd: 1
    )
    proc { Nokogiri::HTML(res.body) }
  end

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.scheduleInner').each_with_object([]) do |li_element, events|
      title = li_element.css('.contents h3').text&.gsub(/[\r\n\t]/, '')
      next if title.blank? || ['「 お休み 」', '「 HALL RENTAL 」'].include?(title)

      act = li_element.css('.artist').text.gsub(/[\t\r]/, '').split("\n").select(&:present?)
      time = li_element.css('.time').text.gsub(/[\r\n\t]/, '')
      price = li_element.css('.price').text.gsub(/[\r\n\t]/, '')
      info = time + ' ' + price
      event = OpenStruct.new(
        title:,
        date: Date.new(current_year_str.to_i, @month.to_i, li_element.css('.day').text.to_i),
        act:,
        info:
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
