class ShimokitazawaEraCrawler < BaseCrawler
  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '下北沢ERA')
  end

  def execute!
    @term.times do |i|
      @month = (now.month + i).to_s.rjust(2, '0')
      request_url = @bar.hp + '/' + current_year_str + '/' + @month + '/?cat=20'
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.schedule-day').each_with_object([]) do |li_element, events|
      title = li_element.css('.event-title').text
      next if ['HALL RENTAL', '【NIGHT TIME】HALL RENTAL'].include?(title)
      next unless act_element = li_element.css('.schedule-announce p').first

      event = OpenStruct.new(
        title: title,
        date: Date.new(current_year_str.to_i, @month.to_i, li_element.css('.date').text.match(/\d+/).to_s.to_i),
        act: act_element.text
                        .gsub(/【ONE MAN】|【TWO MAN】|　…and more!!/, '')
                        .split(' /')
                        .map(&:strip),
        info: li_element.css('.schedule-note').text.gsub(/[\r\n\t]/, '')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
