class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # rubocop:disable Metrics/AbcSize
  def index
    artists = RegisteredArtist::SearchCommand.execute!(
      params[:artist_name],
      params[:selected_area],
      params[:tags]&.split(',')
    )
    @artists = ArtistSummarySerializer.new(artists).serializable_hash[:data].map { |artist| artist[:attributes] }
    @title = "#{params[:artist_name]} #{params[:selected_area]} #{params[:tags]&.split(',')&.join(' ')}"
  end
  # rubocop:enable Metrics/AbcSize

  def show
    artist = RegisteredArtist.includes(:tags, :area).find(params[:id])
    @artist = ArtistDetailSerializer.new(artist).serializable_hash[:data][:attributes]
    render layout: 'artist'
  end

  def new
    @artist = RegisteredArtist.new_hash
    @tags = Tag.to_hash
    @areas = Area.to_hash
  end

  def edit
    @artist = RegisteredArtist.includes(:tags, :area).find(params[:id]).edit_hash
    @tags = Tag.to_hash
    @areas = Area.to_hash
  end
  # rubocop:enable

  def create
    artist = RegisteredArtist.new artist_params
    artist.user = current_user
    artist.save!
    render json: { id: artist.id }
  end

  # 閲覧履歴も作るのでコマンドで分ける
  def update
    artist = RegisteredArtist.find params[:id]
    RegisteredArtist.transaction do
      artist.update! artist_params
      params[:artist].permit(:tag_ids) do |tag_id|
        artist.tags.create(tag_id: tag_id)
      end 
    end
    render json: { id: artist.id }
  end

  private 

  def artist_params
    params[:artist].permit(:id, :name, :icon, :description, :twitter, :hp, :area_id)
  end
end
