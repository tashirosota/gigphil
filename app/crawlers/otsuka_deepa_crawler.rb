class OtsukaDeepaCrawler < BaseCrawler
  def self.execute!
    save_crawling_result(url: url, parser: nokogiri) do |doc|
      format(doc: doc)
    end
  end

  private

  def self.url
    "http://otsukadeepa.jp/schedule/calendar/#{year}/#{month}/"
  end

  def self.format(doc:)
    doc.css(".scheduleList li").each_with_object([]) do |li_element, events|
      event = OpenStruct.new(
        title: li_element.css('h1').text,
        date: li_element.css('.day').text,
        adv: nil,
        door: nil,
        open: nil,
        start: nil,
        act: trim_meta_chars(li_element.css('.act').text.gsub(/\[ACT\]|Photographer：/, '')).split(/\s?\/\s?/),
        info: li_element.css('.btnStyle01').first.attributes['href'].value,
      )
      events << event
    end
  end

  def self.year
    now.year.to_s
  end

  def self.month
    now.month.to_s.rjust(2, '0')
  end
end
