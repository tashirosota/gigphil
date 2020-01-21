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

    header
    move_down 50
    contents

    # @record = record # インスタンスを受け取り。コンポーネント作成時などにレコード内のデータを使える
    text 'hello よだか'

  end
end
