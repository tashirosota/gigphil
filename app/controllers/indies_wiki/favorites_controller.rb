class IndiesWiki::FavoritesController < ApplicationController
  def index; end

  def create
    artist = current_user.favorite_artists.create!(params[:artist_id])
    render json: artist # serializer挟む
  end

  def destroy(id)
    current_user.favorite_artists.find(id).destroy!
    head :ok
  end
end
