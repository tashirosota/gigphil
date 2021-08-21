class IndiesWiki::AreasController < ApplicationController
  # Goに置き換えられました
  def index
    render json: { area_names: Area.all.pluck[:name] }
  end
end
