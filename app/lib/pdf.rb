class Pdf < Prawn::Document

# recordにモデルなどのデータを渡します
  def initialize()

    # superで初期設定を指定します(ページサイズ、マージン等)
    super(
        page_size: 'A4',
        top_margin: 40,
        bottom_margin: 30,
        left_margin: 20,
        right_margin: 20
    )

    font 'app/assets/fonts/k-gothic.ttf'
    stroke_axis

    details
    move_down 50
    text "持ち時間: 20分　転換時間 5分"
    move_down 50
    rehearsals
    move_down 50
    text "顔合わせ: 17:30 OPEN:18:00 START:18:30"
    concerts

    # @record = record # インスタンスを受け取り。コンポーネント作成時などにレコード内のデータを使える
    # text 'hello よだか'

  end

  # @todo中央寄せ
  def details
    table([
              ["タイトル", "short"],
              ["日付", "loooooooooooooooooooong"],
              ["場所", "short"],
              ["備考", "short"]
          ], :position => :center, :width => 500, :column_widths => {0 => 80})
  end

  def rehearsals
    table([
              ["順番", "バンド名", '時間', '演奏', '転換', '備考'],
              ["順番", "バンド名", '時間', '演奏', '転換', '備考'],
          ])
  end

  def concerts
    table([
              ["順番", "バンド名", '時間', '演奏', '転換', '備考'],
              ["順番", "バンド名", '時間', '演奏', '転換', '備考'],
          ])
  end
end
