class IndiesWiki::FavoritesController < ApplicationController
  def index
    artists = current_user.favorite_artists.includes(:tags, :area).order(updated_at: :desc)
    @artists = ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    @title = 'お気に入り一覧'
  end

  def create
    current_user.favorite_artists.create!(params[:artist_id])
    head :ok
  end

  def destroy(id)
    current_user.favorite_artists.find(id).destroy!
    head :ok
  end
end
