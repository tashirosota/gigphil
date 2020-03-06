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
    @artist = {
      id: nil,
      name: nil,
      description: nil,
      icon: '/assets/default_icon.jpeg',
      area: {
        id: nil,
        name: nil
      },
      hp: nil,
      twitter: nil,
      tags: []
    }
    @tags = Tag.all.map { |tag| { id: tag.id, name: tag.name } }
    @areas = Area.all.map { |area| { id: area.id, name: area.name } }
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def edit
    artist = RegisteredArtist.includes(:tags, :area).find(params[:id])
    @artist = {
      id: artist.id,
      name: artist.name,
      description: artist.description,
      icon: artist.icon.url,
      area: {
        id: artist.area.id,
        name: artist.area.name
      },
      hp: artist.hp,
      twitter: artist.twitter,
      tags: artist.tags.map { |tag| { id: tag.id, name: tag.name } }
    }
    @tags = Tag.all.map { |tag| { id: tag.id, name: tag.name } }
    @areas = Area.all.map { |area| { id: area.id, name: area.name } }
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def create
    redirect_to indies_wiki_artist(artist.id), secondary: '保存しました'
  end

  # 閲覧履歴も作るのでコマンドで分ける
  def update
    redirect_to indies_wiki_artist(artist.id), secondary: '保存しました'
  end
end
