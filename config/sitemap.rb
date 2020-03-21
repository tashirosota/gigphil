# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.gigphil.app"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/indies_wiki', :priority => 1.0, :changefreq => 'daily'
  add '/searcher'
  add '/TT'
  add '/statics/terms', :priority => 0.1
  add '/statics/privacy', :priority => 0.1
  add indies_wiki_artists_path, :priority => 0.9, :changefreq => 'daily'
  RegisteredArtist.find_each do |artist|
    add indies_wiki_artist_path(artist), :priority => 0.8, :lastmod => artist.updated_at, :changefreq => 'daily'
  end
end
