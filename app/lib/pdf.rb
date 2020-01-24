class Pdf < Prawn::Document

  # @param [Object] params
  def initialize(params)

    super(
        page_size: 'A4',
        top_margin: 40,
        bottom_margin: 30,
        left_margin: 20,
        right_margin: 20
    )

    time_table = params['timeTable']

    @details = [['タイトル', time_table['title']],
                ['日付', time_table['eventDate']],
                ['場所', time_table['place']],
                ['備考', time_table['memo']]]

    # テーブル用に整列&整列
    @rehearsal_tables = time_table['rehearsals'].map do |rehearsal|
      Array[rehearsal['order'],
            rehearsal['bandName'],
            rehearsal['playTimeRange'],
            rehearsal['customPlayTime'] ||= time_table['rehearsalPlayTime'],
            rehearsal['customSettingTime'] ||= time_table['rehearsalSettingTime'],
            rehearsal['memo']
      ]
    end

    # テーブル用に整列&整列
    @production_tables = time_table['concerts'].map do |production|
      Array[production['order'],
            production['bandName'],
            production['playTimeRange'],
            production['customPlayTime'] ||= time_table['productionPlayTime'],
            production['customSettingTime'] ||= time_table['productionSettingTime'],
            production['memo']
      ]
    end

    set_config
    render_pdf time_table
  end

  def set_config
    font 'app/assets/fonts/k-gothic.ttf'
    # ↓これでメモリが現れる
    # stroke_axis
  end

  # ここで指定した通りに描画される
  def render_pdf(time_table)
    move_down 50
    details
    move_down 50
    # text "持ち時間: #{time_table['rehearsalPlayTime']}分　転換時間 #{time_table['rehearsalSettingTime']}分"
    text 'リハーサル', align: :center
    move_down 10
    rehearsals
    move_down 50
    text "顔合わせ: #{time_table['meetingTime']} OPEN:#{time_table['openTime']} START:#{time_table['startTime']}", align: :center
    move_down 50
    # text "持ち時間: #{time_table['productionPlayTime']}分　転換時間 #{time_table['productionSettingTime']}分"
    text '本番', align: :center
    move_down 10
    concerts
  end

  # @todoカラム内中央寄せ
  def details
    table(@details, position: :center, width: 500, column_widths: {0 => 80})
  end

  def rehearsals
    @rehearsal_tables.unshift ['順番', 'バンド名', '時間', '演奏', '転換', '備考']
    table(@rehearsal_tables, position: :center, width: 500, column_widths: {0 => 80})
  end

  def concerts
    @production_tables.unshift ['順番', 'バンド名', '時間', '演奏', '転換', '備考']
    table(@production_tables, position: :center, width: 500, column_widths: {0 => 80})
  end
end
