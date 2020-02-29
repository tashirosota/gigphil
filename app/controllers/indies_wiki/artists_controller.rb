class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # indexのartistsとshowのartistsはserializer分ける
  # fatになると思う
  # indexはsearchなのでserviceに切り出す
  def index
    # stories = RegisteredArtist::SearchCommand.execute!(params[:artist_name], params[:area], params[:tags])
    tags = Tag.all.map(&:name)
    areas = Area.all.map(&:name)
    artists = RegisteredArtist.all.map(&:name)
    @artists = []
    10.times do
      @artists << {
        name: artists.sample,
        area: areas.sample,
        tags: tags.shuffle.take(3),
        icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
      }
    end

    @title = "検索ワード: #{params[:artist_name]}, #{params[:selected_area]}, #{params[:tags]}"
  end

  def show(id)
    render json: RegisteredArtist.find(id) # TODO: serializer
  end

  def new; end

  def edit; end

  def create; end

  # 閲覧履歴も作るのでコマンドで分ける
  def update; end

  # destroyは一旦出来なくする
  # def destroy; end
end
