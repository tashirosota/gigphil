class ShimokitazawaBasementBarCrawler < BaseCrawler
  CALENDAR_PATH = '/event/on'.freeze

  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢BASEMENTBAR')
  end

  # rubocop:disable Metrics/AbcSize
  def execute!
    @term.times do |i|
      daily_ary(i).each do |day|
        request_url = @bar.hp + CALENDAR_PATH + '/' + current_year_str + '/' + @month + '/' + day
        save_crawling_result(url: request_url, parser: nokogiri) do |doc|
          format(
            date: Date.new(current_year_str.to_i, @month.to_i, day.to_i),
            doc: doc
          )
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def format(date:, doc:)
    doc.css('.content-area article').each_with_object([]) do |li_element, events|
      title = li_element.css('.eo-event-title.entry-title').text.gsub(/[\r\n\t]/, '')
      next if title.blank? || title.include?('OFF') || title.include?('メンテナンス')

      info, artists_str = li_element.css('.eo-event-content').text.split(/ACT/).map(&:strip)
      event = OpenStruct.new(
        title: title,
        date: date,
        # basementbarはアーティスト名入力してないケースが多すぎる フライヤー表示も考えないとイケナイ
        act: (artists_str&.split(/ /) || []) + [artists_str],
        info: info
      )
      events << event
    end
  end

  def daily_ary(term_count)
    set_month_instanse(term_count)
    day_count = Date.new(current_year_str.to_i, @month.to_i, -1).day
    (1..day_count).map { |day| day.to_s.rjust(2, '0') }
  end
end
