# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.gigphil.app"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['S3_BUCKET'],
  aws_access_key_id: ENV['AWS_ACCESS_KEY'],
  aws_secret_access_key: ENV['AWS_SECRET_KEY'],
  aws_region: 'ap-northeast-1',
)
SitemapGenerator::Sitemap.create do
  add '/indies_wiki', :priority => 1.0, :changefreq => 'daily'
  add '/searcher'
  add '/TT'
  add '/statics/terms', :priority => 0.1
  add '/statics/privacy', :priority => 0.1
  add indies_wiki_artists_path, :priority => 0.9, :changefreq => 'daily'
  RegisteredArtist.find_each do |artist|
    add indies_wiki_artist_path(artist), :priority => 0.8, :lastmod => artist.updated_at, :changefreq => 'daily'
  end
  now = Time.zone.now
  10.times do |i|
    add result_path({ "year(1i)" => (now + i.day).year, "month(2i)" => (now + i.day).month, "day(3i)" => (now + i.day).day, is_date_search: '0'} ), :priority => 0.9, :lastmod => Time.zone.now, :changefreq => 'daily'
  end
  add result_path({ "year(1i)" => now.year, "month(2i)" => now.month} ), :priority => 0.5, :lastmod => Time.zone.now, :changefreq => 'daily'
end
