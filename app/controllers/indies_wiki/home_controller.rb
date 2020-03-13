class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    @up_artists = up_artists
    @pickup_artists = pickup_artists
    @random_artists = random_artists
    @popular_tag_artists = popular_tag_artists
    @total_count = RegisteredArtist.all.size
    @tags = Tag.names
    @areas = Area.names
  end

  private

  def up_artists
    artists = RegisteredArtist.includes(:tags, :area).order(updated_at: :desc).limit(10)
    ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
  end

  def pickup_artists
    artists = RegisteredArtist.includes(:tags, :area).where(id: [1, 3, 6, 11, 12, 14]).order(Arel.sql('Random()'))
    ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
  end

  def random_artists
    artists = RegisteredArtist.includes(:tags, :area).order(Arel.sql('Random()')).limit(10)
    ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
  end

  def popular_tag_artists
    sql = <<~SQL
      SELECT
        tags.id
      FROM tags
      JOIN tag_to_registered_artists ON tags.id = tag_to_registered_artists.tag_id
      GROUP BY tags.id
      ORDER BY COUNT(*)
      LIMIT 1
    SQL
    tag_id = Tag.find_by_sql(sql).map(&:id).first
    artists = RegisteredArtist.joins(:tags).where("tags.id = #{tag_id}").limit(10)
    ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
  end
end
