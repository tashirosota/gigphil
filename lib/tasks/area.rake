# rubocop:disable all
namespace :area do
  desc 'Create records for initial state'
  task create_initial_data: :environment do
    names = %w(北海道 青森 岩手 宮城 秋田 山形 福島 茨城 栃木 宇都宮 足利 群馬 高崎 埼玉 越谷 千葉 東京 大塚 八王子 下北沢 吉祥寺 渋谷 新宿 神奈川 新潟 富山 石川 福井 山梨 長野 岐阜 静岡 愛知 三重 滋賀 京都 大阪 寝屋川 兵庫 姫路 奈良 和歌山 鳥取 島根 岡山 広島 山口 徳島 香川 愛媛 高知 福岡 佐賀 長崎 熊本 大分 宮崎 鹿児島 沖縄)
    names.each do |name|
      Area.create!(name: name)
    rescue ActiveRecord::RecordInvalid
      next
    end
  end
end
# rubocop:enable all