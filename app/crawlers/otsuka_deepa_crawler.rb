class OtsukaDeepaCrawler < BaseCrawler
  def self.execute!
    save_crawling_result(url: url) do |doc|
      format(doc: doc)
    end
  end

  private

  def self.url
    "http://otsukadeepa.jp/schedule/calendar/#{year}/#{month}/"
  end

  # Returns instances of OpenStruct
  def self.format(doc:)
    doc.css(".scheduleList li").each_with_object([]) do |center_cont, events|
      pp '========'
      pp center_cont
      # TODO: 改善の余地あり
      event = OpenStruct.new(
        title: nil,
        date: nil,
        adv: nil,
        door: nil,
        open: nil,
        start: nil,
        act: nil,
        info: nil
      )
      event.title = "#{center_cont.content.split(/(])/)[0]}#{center_cont.content.split(/(])/)[1]}"
      only_info_and_act = center_cont.content.gsub(event.title, '').split(/(OPEN)/)
      event.act = only_info_and_act[0]
      event.info = "#{only_info_and_act[1]}#{only_info_and_act[2]}"
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
