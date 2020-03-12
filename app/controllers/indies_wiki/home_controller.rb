class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    up_artists = RegisteredArtist.includes(:tags, :area).order(updated_at: :desc).limit(10)
    @up_artists = ArtistSummarySerializer.new(up_artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    pickup_artists = RegisteredArtist.includes(:tags, :area).where(id: [1, 3, 6, 11, 12, 14]).order(updated_at: :desc)
    @pickup_artists = ArtistSummarySerializer.new(pickup_artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    @total_count = RegisteredArtist.all.size
    @tags = Tag.names
    @areas = Area.names
  end
end
