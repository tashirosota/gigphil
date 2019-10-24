# rubocop:disable all
namespace :musicbar do
  desc 'Create records for initial state'
  task create_initial_data: :environment do
    if ::MusicBar.count.positive?
      puts 'It seems that MusicBar records are already created.'
    else
      [
        { name: '大塚Deepa', place: '東京都豊島区南大塚3-49-10 大塚鈴本ビルB1f', hp: 'https://otsukadeepa.jp' },
        { name: '下北沢BASEMENTBAR', place: '東京都世田谷区代沢5-18-1 カラバッシュビルB1F', hp: 'https://toos.co.jp/basementbar' },
        { name: '下北沢DaisyBar', place: '東京都世田谷区北沢2-2-3 エルサント北沢B1', hp: 'https://daisybar.jp' },
        { name: '下北沢ERA', place: '東京都世田谷区北沢2-34-5 プリマヴェール下北沢4F', hp: 'http://s-era.jp' },
        { name: '下北沢mona records', place: '東京都世田谷区北沢2-13-5 伊奈ビル2F&3F', hp: 'http://www.mona-records.com' },
        { name: '西永福JAM', place: '東京都杉並区永福3-34-14 B1F', hp: 'http://jam.rinky.info' },
        { name: '下北沢SHELTER', place: '東京都世田谷区北沢2-6-10仙田ビルB1', hp: 'https://www.loft-prj.co.jp' },
        { name: '下北沢MOSAiC', place: '東京都世田谷区北沢2-2-14モアイ茶沢1F.B1', hp: 'http://mu-seum.co.jp' },
        { name: '大塚Hearts+', place: '東京都豊島区北大塚2-16-7 セイコーガーデン11大塚 B1', hp: 'http://hearts-web.net' },
        { name: '新宿SAMURAI', place: '東京都新宿区歌舞伎町2-42-16 第2大滝ビルB1', hp: 'https://live-samurai.jp' },
        { name: '渋谷CRAWL', place: '東京都渋谷区東1-25-2 マルハシビルB1', hp: 'http://bighitcompany.com' },
        { name: '渋谷O-Crest', place: '東京都渋谷区道玄坂２丁目１４−８ 5f', hp: 'https://shibuya-o.com/whats-on/tsutaya-o-crest' },
        { name: '新宿LOFT', place: '東京都新宿区歌舞伎町1-12-9 タテハナビルB2', hp: 'https://www.loft-prj.co.jp' },
        { name: '吉祥寺Planet K', place: '東京都武蔵野市吉祥寺本町１−８−１０ 八番館ビルB1', hp: 'http://inter-planets.net' },
        { name: '吉祥寺Warp', place: '東京都武蔵野市吉祥寺本町1-30-10', hp: 'http://warp.rinky.info' }

      ].map { |hsh| ::MusicBar.create!(hsh) }
      puts 'Created MusicBar records. **It can be old and different from actual MusicBars. Please check.**'
    end
  end

  task scraping_all: :environment do
    crawlers = [
      OtsukaDeepaCrawler,
      ShimokitazawaBasementBarCrawler,
      ShimokitazawaDaisyBarCrawler,
      ShimokitazawaEraCrawler,
      ShimokitazawaMonarecordsCrawler,
      NishieifukuJamCrawler,
      ShimokitazawaShelterCrawler,
      ShimokitazawaMosaicCrawler,
      OtsukaHeartsCrawler,
      ShinjukuSamuraiCrawler,
      ShibuyaCrawlCrawler,
      ShibuyaCrestCrawler,
      ShinjukuLoftCrawler,
      KichijojiPlanetkCrawler,
      KichijojiWarpCrawler
    ]
    crawlers.each do |klass|
      Rails.logger.info klass
      klass.execute!
    end
  end
end
# rubocop:enable all