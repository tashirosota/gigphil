namespace :tag do
  desc 'Create records for initial state'
  task create_initial_data: :environment do
    names = %w(パワーポップ シューゲイザー ギターロック オルタナ エモ ハードコア 激情 メロコア ピアノロック jazz UK US ラップ カントリー アイドル SSW 若手 10代 社会人 シティポップ グランジ ポストロック 電子 歌もの 3ピース)
    names.each do |name|
      Tag.create!(name: name)
    rescue ActiveRecord::RecordInvalid
      next
    end
  end
end
