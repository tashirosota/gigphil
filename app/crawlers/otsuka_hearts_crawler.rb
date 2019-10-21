class OtsukaHeartsCrawler < BaseCrawler
  CALENDAR_PATH = '/plus/live-schedule'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '大塚Haerts+')
  end

  def execute!
    @term.times do |i|
      @month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + CALENDAR_PATH + '/' + "/?y=#{current_year_str}&m=#{@month}"
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.liveSpec').each_with_object([]) do |li_element, events|
      info_ary = li_element.css('.list.liveSpec li')
      next if li_element.css('.theTitle').blank? || info_ary.count == 1 || info_ary.count.zero?

      event = OpenStruct.new(
        title: li_element.css('.theTitle').text,
        date: Date.new(current_year_str.to_i, @month.to_i, li_element.css('.theDay').text.to_i),
        act: info_ary.first.text.gsub(/[\r\n\t]/, '').split(' / '),
        info: info_ary[1].text.gsub(/[\r\n\t]/, '')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
