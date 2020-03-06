class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    # 仮置
    up_artists = RegisteredArtist.includes(:tags, :area).order(updated_at: :desc).limit(20)
    @up_artists = ArtistSummarySerializer.new(up_artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    @tags = Tag.all.pluck(:name)
    @areas = Area.all.pluck(:name)
  end
end
