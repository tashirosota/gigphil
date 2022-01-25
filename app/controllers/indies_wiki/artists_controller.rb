class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # rubocop:disable Metrics/AbcSize
  def index
    artists = RegisteredArtist::SearchCommand.execute!(
      params[:artist_name],
      params[:selected_area],
      params[:tags]&.split(',')
    )
    @artists = ArtistSummarySerializer.new(artists).serializable_hash[:data].pluck(:attributes)
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
    RegisteredArtist.transaction do
      artist.save!
      params[:artist][:tag_ids]&.each do |tag_id|
        artist.tag_to_registered_artists.create!(tag_id:)
      end
    end
    render json: { id: artist.id }
  end

  # 閲覧履歴も作るのでコマンドで分ける
  def update # rubocop:disable all
    artist = RegisteredArtist.find params[:id]
    RegisteredArtist.transaction do
      artist.edit_histories.create!(
        editor_id: current_user.id,
        old_name: artist.name,
        old_hp: artist.hp,
        old_description: artist.description,
        old_area: artist.area.name
      )
      artist.update! artist_params
      artist.tags.delete_all
      params[:artist][:tag_ids]&.each do |tag_id|
        artist.tag_to_registered_artists.create!(tag_id:)
      end
    end
    render json: { id: artist.id }
  end

  private

  def artist_params
    params[:artist].permit(:id, :name, :icon, :description, :twitter, :hp, :mv, :area_id)
  end
end
