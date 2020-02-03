class IndiesWiki::HomeController < ApplicationController
  def show
    home = {} # ホームは巨大なserializerにする
    render json: { home: home }
  end
end
