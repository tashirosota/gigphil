class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    up_artists = RegisteredArtist.includes(:tags, :area).order(updated_at: :desc).limit(10)
    @up_artists = ArtistSummarySerializer.new(up_artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    @tags = Tag.names
    @areas = Area.names
  end
end
