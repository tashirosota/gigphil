# musicbar_id, date, word
# [検索パターン]
# ライブハウス * 月
# ライブハウス * 月日
# ライブハウス * 月 * ワード
# ライブハウス * ワード
# 月 * ワード
# 月日 * ワード
# ワード
class SearchCommand
  def initialize(musicbar_id, date, word)
    @musicbar_id, @date, @word = musicbar_id, date, word
  end

  def execute!
    # 愚直に条件分岐
  end

  private

  def bar_and_month; end
  def bar_and_date; end
  def bar_and_month_and_word; end
  def bar_and_word; end
  def month_and_word; end
  def date_and_word; end
  def word; end
end