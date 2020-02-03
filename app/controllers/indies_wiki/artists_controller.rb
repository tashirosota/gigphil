class IndiesWiki::ArtistsController < ApplicationController
  # indexのartistsとshowのartistsはserializer分ける
  # fatになると思う
  # indexはsearchなのでserviceに切り出す
  def index
    stories = RegisteredArtist::SearchCommand.execute
    render json: stories # TODO: serializer
  end

  def show(id)
    render json: RegisteredArtist.find(id) # TODO: serializer
  end

  def create; end

  # 閲覧履歴も作るのでコマンドで分ける
  def update; end

  # destroyは一旦出来なくする
  # def destroy; end
end
