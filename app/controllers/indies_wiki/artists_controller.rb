class IndiesWiki::ArtistsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  # indexのartistsとshowのartistsはserializer分ける
  # fatになると思う
  # indexはsearchなのでserviceに切り出す
  def index
    stories = RegisteredArtist::SearchCommand.execute!(params[:artist_name], params[:area], params[:tags])
    render json: stories # TODO: serializer
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
