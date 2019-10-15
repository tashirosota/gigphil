require 'open-uri'
class BaseCrawler
  def initialize(term)
    @term = term
  end

  def self.execute!
    new(2).execute!
  end

  def save_crawling_result(url:, parser:)
    doc = parser.call(url)
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
    proc { |url| Nokogiri::HTML(URI.parse(url).open) }
  end

  # TODO: 別classに切り出す?
  def trim_meta_chars(char)
    char.gsub(/\t+|\n+|\r+/, '')
  end

  def now
    @now ||= Time.zone.now
  end

  def current_year
    now.year.to_s
  end

  def current_month
    now.month.to_s.rjust(2, '0')
  end

  # fatだけどserviceとか導入するのもあれなので、ここで受け入れる
  # rubocop:disable all
  def update_all_assosiation_by!(result_schedule:)
    target_schedule = @bar.schedules.find_or_initialize_by(
      event_date: result_schedule.date.all_day,
      title: result_schedule.title
    )

    target_schedule.update!(
      event_date: result_schedule.date,
      open: result_schedule.open,
      start: result_schedule.start,
      adv: result_schedule.adv&.to_i,
      door: result_schedule.door&.to_i
    )

    # artist名が空のケースがあるので除外
    result_schedule.act.each do |artist_name|
      return false if artist_name.blank?

      artist = Artist.find_or_initialize_by(name: artist_name)
      artist.save!
      artist.artist_to_schedules.create!(schedule: target_schedule)
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
#       adv: Integer (allow nil),
#       door: Integer (allow nil),
#       open: DateTime (allow nil),
#       start: DateTime (allow nil),
#       act: [String, String],
#       info: String,
#     },
#     {
#       title: String,
#       event_date: DateTime,
#       adv: Integer (allow nil),
#       door: Integer (allow nil),
#       open: DateTime (allow nil),
#       start: DateTime (allow nil),
#       act: [String, String],
#       info: String,
#     },
#   ]
# }
