class KichijojiPlanetkCrawler < BaseCrawler
  CALENDAR_PATH = '/calendar/action~agenda/page_offset~'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '吉祥寺Planet K')
  end

  def execute!
    @term.times do |i|
      request_url = @bar.hp + CALENDAR_PATH + i.to_s
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc:)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def format(doc:)
    doc.css('.ai1ec-date').each_with_object([]) do |li_element, events|
      title = li_element.css('.ai1ec-event-title').text.gsub(/[\r\n\t]/, '')
      next if %w(ホールレンタル 詳細後日解禁).include? title

      dates = li_element.css('.ai1ec-event-time').text.gsub(/[\r\n\t]/, '').split(/月|@/).map(&:to_i)
      descriptions = li_element.css('.ai1ec-event-description p')
      next if descriptions.count < 2

      act = descriptions.first.css('strong').map(&:text)
      info = descriptions[2..].map(&:text).join
      @month = dates[0]
      event = OpenStruct.new(
        title:,
        date: Date.new(current_year_str.to_i, dates[0], dates[1]),
        act:,
        info:
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
