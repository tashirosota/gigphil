class ShibuyaCrestCrawler < BaseCrawler
  CALENDAR_PATH = '/whats-on-filtered'.freeze
  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '渋谷O-Crest')
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
      URI.parse('https://shibuya-o.com' + CALENDAR_PATH),
      action: 'event_list',
      'year-month' => current_year_str + '-' + @month.to_s,
      venue: 172
    )
    proc { Nokogiri::HTML(res.body) }
  end

  def format(doc:)
    doc.css('.schedule-event.row').each_with_object([]) do |li_element, events|
      day = li_element.css('.schedule-date strong').text.to_i
      event = OpenStruct.new(
        title: li_element.css('.schedule-details h4').text.gsub(/[\r\n\t]/, '').gsub(' ', ''),
        date: Date.new(current_year_str.to_i, @month.to_i, day),
        act: li_element.css('label span').map(&:text),
        info: ''
      )
      events << event
    end
  end
end
