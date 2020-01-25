class Pdf < Prawn::Document
  # @param [Object] params
  def initialize(time_table)
    @time_table = time_table
    super(
        page_size: 'A4',
        top_margin: 40,
        bottom_margin: 30,
        left_margin: 20,
        right_margin: 20
    )
    render_pdf
  end

  private

  # ここで指定した通りに描画される
  def render_pdf
    font 'app/assets/fonts/k-gothic.ttf'
    details
    move_down 20
    # text "持ち時間: #{time_table['rehearsalPlayTime']}分　転換時間 #{time_table['rehearsalSettingTime']}分"
    text '【リハーサル】', align: :center
    move_down 10
    rehearsals
    move_down 20
    # text "持ち時間: #{time_table['productionPlayTime']}分　転換時間 #{time_table['productionSettingTime']}分"
    text '【本番】', align: :center
    move_down 10
    concerts
  end

  # @todoカラム内中央寄せ
  def details
    time_text = '顔合わせ: ' + @time_table['meetingTime'] + \
                ' / OPEN: ' + @time_table['openTime'] + \
                ' / START: ' + @time_table['startTime']
    data = [['タイトル', @time_table['title']],
            ['日付', @time_table['eventDate']],
            ['場所', @time_table['place']],
            ['備考', @time_table['memo']],
            ['時間', time_text]]
    table(data, position: :center, width: 500, column_widths: { 0 => 80 })
  end

  def rehearsals
    data = @time_table['rehearsals'].map do |rehearsal|
      Array[rehearsal['order'],
            rehearsal['bandName'],
            rehearsal['playTimeRange'],
            rehearsal['memo']
      ]
    end
    data.unshift %w(順番 バンド名 時間 備考)
    table(data, position: :center, width: 500, column_widths: { 0 => 40 })
  end

  def concerts
    data = @time_table['concerts'].map do |production|
      Array[production['order'],
            production['bandName'],
            production['playTimeRange'],
            production['memo']
      ]
    end
    data.unshift %w(順番 バンド名 時間 備考)
    table(data, position: :center, width: 500, column_widths: { 0 => 40 })
  end
end
