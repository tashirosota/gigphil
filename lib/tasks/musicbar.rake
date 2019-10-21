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
        { name: '下北沢mona records', place: '東京都世田谷区北沢2-13-5 伊奈ビル2F&3F', hp: 'http://www.mona-records.com' }
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
      ShimokitazawaMonarecordsCrawler
    ]
    crawlers.each do |klass|
      Rails.logger.info klass
      klass.execute!
    end
  end
end
# rubocop:enable all