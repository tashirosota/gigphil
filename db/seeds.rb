# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bars = []
bars << MusicBar.create!(name: '大塚Deepa', place: '東京都豊島区南大塚3-49-10 大塚鈴本ビルB1f' ,hp: 'https://otsukadeepa.jp')
bars << MusicBar.create!(name: '下北沢BASEMENTBAR', place: '東京都世田谷区代沢5-18-1 カラバッシュビルB1F' ,hp: 'https://toos.co.jp/basementbar')
bars << MusicBar.create!(name: '下北沢DaisyBar', place: '東京都世田谷区北沢2-2-3 エルサント北沢B1' ,hp: 'https://daisybar.jp/')
bars << MusicBar.create!(name: '下北沢ERA', place: '東京都世田谷区北沢2-34-5 プリマヴェール下北沢4F' ,hp: 'http://s-era.jp/')

10.times do |i|
  artist = Artist.new(name: Faker::Music::RockBand.name)
  loop do
    artist.save! && break if artist.valid? 
    artist.name = Faker::Music::RockBand.name
  end
end

bars.each do |bar|
  10.times do |i|
    date = Faker::Time.between(from: Time.zone.now + 2.month, to: Time.zone.now + 1.year)
    event = bar.schedules.new(
      title: Faker::Book.title,
      event_date: date,
      info: Faker::Beer.name
    )
    loop do
      event.save! && break if event.valid? 
      event.title = Faker::Book.title
    end

    3.times do |i|
      event_artist = event.artist_to_schedules.new(artist: Artist.all.sample)
      loop do
        event_artist.save! && break if event_artist.valid? 
        event_artist.artist = Artist.all.sample
      end
    end
  end
end

10.times do |i|
  user = User.create_with_tokens
  user_schedule = user.user_to_schedules.new(schedule: Schedule.all.sample)
  loop do
    user_schedule.save! && break if user_schedule.valid? 
    user_schedule.schedule = Schedule.all.sample
  end
end


