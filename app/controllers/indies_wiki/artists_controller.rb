class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # indexのartistsとshowのartistsはserializer分ける
  # fatになると思う
  # indexはsearchなのでserviceに切り出す
  def index
    # stories = RegisteredArtist::SearchCommand.execute!(params[:artist_name], params[:area], params[:tags])
    tags = Tag.all.map(&:name)
    areas = Area.all.map(&:name)
    artists = RegisteredArtist.all
    @artists = []
    10.times do
      @artists << {
        id: artists.sample.id,
        name: artists.sample.name,
        area: areas.sample,
        tags: tags.shuffle.take(3),
        icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
      }
    end

    @title = "#{params[:artist_name]}, #{params[:selected_area]}, #{params[:tags]}"
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
      tags: Tag.all.map(&:name).shuffle.take(3),
      is_favorite: true,
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
      comments: ['テストコメントテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さんテストコメントby誰々さん  by誰々さん','テストdsfsfdコメントby誰々さん','テストコメントby誰々さん','テストdsfsfdコメントby誰々さん','テストコメントby誰々さん','テストdsfsfdコメントby誰々さん','テストコメントby誰々さん','テストdsfsfdコメントby誰々さん'],
      histories: ['テストコメントby誰々さん','テストdsfsfdコメントby誰々さん','テストコメントby誰々さん','テストdsfsfdコメントby誰々さん','テストコメントby誰々さん','テストdsfsfdコメントby誰々さん']
    }
  end

  def new; end

  def edit; end

  def create; end

  # 閲覧履歴も作るのでコマンドで分ける
  def update; end

  # destroyは一旦出来なくする
  # def destroy; end
end
