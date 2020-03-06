class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # indexのartistsとshowのartistsはserializer分ける
  # fatになると思う
  # indexはsearchなのでserviceに切り出す
  def index
    @stories = RegisteredArtist::SearchCommand.execute!(params[:artist_name], params[:selected_area], params[:tags].split(','))
    @title = "#{params[:artist_name]} #{params[:selected_area]} #{params[:tags].split(',').join(' ')}"
  end

  def show
    # render json: RegisteredArtist.find(id) # TODO: serializer
    artist = RegisteredArtist.find(params[:id])
    @artist = {
      id: 1,
      name: artist.name + artist.name,
      description: artist.description + artist.description + artist.description,
      icon: 'https://somedaysgone.com/assets/imgs/about/somedaysgone.jpg',
      area: '新宿',
      hp: artist.hp,
      twitter: artist.twitter,
      tags: Tag.all.map(&:name).shuffle.take(10),
      is_favorite: false,
      sounds: [
        {
          title: '長いタイトル長いタイトル長いタイトルミニアルバムAppleMusic',
          url: 'https://example.com'
        },
        {
          title: 'ミニアルバムSpotify',
          url: 'https://example.com'
        },
        {
          title: 'MV(Youtube)',
          url: 'https://example.com'
        },
        {
          title: 'MV(Youtube)',
          url: 'https://example.com'
        }
      ],
      commentable: false,
      comments: ['テストコメントテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さん  by誰々さん', 'テストdsfsfdコメントby誰々さん', 'テストコメントby誰々さん', 'テストdsfsfdコメントby誰々さん', 'テストコメントby誰々さん', 'テストdsfsfdコメントby誰々さん', 'テストコメントby誰々さん', 'テストdsfsfdコメントby誰々さん'],
      histories: %w(テストコメントby誰々さん テストdsfsfdコメントby誰々さん テストコメントby誰々さん テストdsfsfdコメントby誰々さん テストコメントby誰々さん テストdsfsfdコメントby誰々さん)
    }
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

  def edit; end

  def create; end

  # 閲覧履歴も作るのでコマンドで分ける
  def update; end

  # destroyは一旦出来なくする
  # def destroy; end
end
