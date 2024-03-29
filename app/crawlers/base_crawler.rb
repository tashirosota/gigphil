require 'open-uri'
class BaseCrawler
  def initialize(term)
    @term = term
  end

  def self.execute!
    new(4).execute!
  end

  def save_crawling_result(url:, parser:)
    return unless doc = parser.call(url)

    schedules = yield(doc)

    ActiveRecord::Base.transaction do
      schedules.each do |schedule|
        update_all_assosiation_by!(result_schedule: schedule)
      end
    end
  end

  def execute!
    raise NotImplementedError, 'Implement .execute! to the subclass'
  end

  private

  def nokogiri
    proc do |url|
      Nokogiri::HTML(URI.parse(url).open)
    rescue OpenURI::HTTPError
      # NOT FOUNDが出たら回避
      nil
    end
  end

  # TODO: 別classに切り出す?
  def trim_meta_chars(char)
    char.gsub(/\t+|\n+|\r+/, '')
  end

  def now
    @now ||= Time.zone.now
  end

  def current_year_str
    return now.year.to_s unless @month

    year = now.month <= @month.to_i ? now.year : now.year + 1
    year.to_s
  end

  def current_month_str
    now.month.to_s.rjust(2, '0')
  end

  # rubocop:disable Naming/AccessorMethodName
  def set_month_instanse(term)
    month = current_month_str.to_i + term
    @month = (month < 13 ? month : month - 12).to_s.rjust(2, '0')
  end
  # rubocop:enable Naming/AccessorMethodName

  # fatだけどserviceとか導入するのもあれなので、ここで受け入れる
  # rubocop:disable all
  def update_all_assosiation_by!(result_schedule:)
    return false if result_schedule.title.blank?
    target_schedule = @bar.schedules.find_or_initialize_by(event_date: result_schedule.date.all_day, title: result_schedule.title)

    target_schedule.update!(
      event_date: result_schedule.date,
      info: result_schedule.info
    )

    # artist名が空のケースがあるので除外
    result_schedule.act.each do |artist_name|
      return false if artist_name.blank?
      artist = Artist.find_or_initialize_by(name: artist_name)
      artist.save!
      schedule = artist.artist_to_schedules.find_or_initialize_by(schedule: target_schedule)
      schedule.save!
    end
  end
  # rubocop:enable all
end

# NOTICE: クローリング結果を返す `subclass#format` の返り値 (OpenStruct)
# {
#   name: '大塚Deepa',
#   schedules: [
#     {
#       title: String,
#       event_date: DateTime,
#       act: [String, String],
#       info: String,
#     },
#     {
#       title: String,
#       event_date: DateTime,
#       act: [String, String],
#       info: String,
#     },
#   ]
# }
