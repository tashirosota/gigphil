class SearchCommand
  def initialize(musicbar_id, year, month, day, word)
    @musicbar_id = musicbar_id
    @year = year
    @month = month
    @day = day
    @word = word
  end

  def execute!
    by_musicbar_id by_day by_word init_model
  end

  private

  def init_model
    Schedule.joins(:music_bar, :artists).order(event_date: :desc)
  end

  def by_word(model)
    @word.present? ? model.where('artists.name LIKE :word', word: "%#{@word}%") : model
  end

  def by_musicbar_id(model)
    @musicbar_id ? model.where('music_bars.id = :id', id: @musicbar_id) : model
  end

  def by_day(model)
    if @day
      model.where("TO_CHAR(event_date,'YYYY/MM/DD') = '#{format_date}'")
    else
      model.where("TO_CHAR(event_date,'YYYY/MM') = '#{format_month}'")
    end
  end

  def format_date
    Date.new(@year, @month, @day).strftime('%Y/%m/%d')
  end

  def format_month
    Date.new(@year, @month).strftime('%Y/%m')
  end
end
