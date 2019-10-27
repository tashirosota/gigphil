class ShinjukuSamuraiCrawler < BaseCrawler
  def initialize(term)
    super term
    @bar = MusicBar.find_by!(name: '新宿SAMURAI')
  end

  def execute!
    @term.times do |i|
      set_month_instanse(i)
      request_url = @bar.hp + '/' + current_year_str + '/' + @month
      save_crawling_result(url: request_url, parser: nokogiri) do |doc|
        format(doc: doc)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def format(doc:)
    doc.css('.infoListBox.ttBox').each_with_object([]) do |li_element, events|
      # ひどい
      day = li_element.css('table tbody tr td')[0].text.reverse.match(/\d+/).to_s.reverse.to_i # 後方からmatch探したかった
      info_text = li_element.css('.post2')[1].text.gsub(/[\r\n\t]/, '')
      act_text = li_element.css('.post2')[1].css('tr')[2].css('td')[1].text
      event = OpenStruct.new(
        title: li_element.css('.entryTitle').text.gsub(/[\r\n\t]/, ''),
        date: Date.new(current_year_str.to_i, @month.to_i, day),
        act: act_text.gsub(/[\r\n\t]/, '').split(' / '),
        info: info_text.gsub(act_text, '')
      )
      events << event
    end
  end
  # rubocop:enable Metrics/AbcSize
end
