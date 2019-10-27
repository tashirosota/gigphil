class ShimokitazawaMosaicCrawler < BaseCrawler
  CURRENT_MONTH_CALENDAR_PATH = '/schedule.html'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢MOSAiC')
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def execute!
    @term.times do |i|
      set_month_instanse(i)
      request_url = if i.zero?
                      @bar.hp + CURRENT_MONTH_CALENDAR_PATH
                    else
                      @bar.hp + + '/' + current_year_str + @month + '.html'
                    end
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  def format(doc:)
    doc.css('.centerCont.bottomLiner').each_with_object([]) do |li_element, events|
      title = li_element.css('.live_title').text.presence \
        || li_element.css('.live_title_sat').text.presence \
        || li_element.css('.live_title_sun').text.presence
      dates = li_element.css('tr th').first.text.split('/').map(&:to_i)
      date = if li_element.css('tr th').first.text.present? # ない場合がある
               Date.new(current_year_str.to_i, @month.to_i, dates[1])
             else
               events.last.date
             end
      event = OpenStruct.new(
        title: title,
        date: date,
        act: li_element.css('.live_menu strong').text.split(' / '),
        info: li_element.css('.live_menu').text.gsub(li_element.css('.live_menu strong').text, '')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
