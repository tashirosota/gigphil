class IndiesWiki::AreasController < ApplicationController
  def index
    render json: { area_names: Area.all.pluck[:name] }
  end
end
