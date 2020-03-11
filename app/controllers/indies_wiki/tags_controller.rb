class IndiesWiki::TagsController < ApplicationController
  def index
    render json: { area_names: Tag.all.pluck[:name] }
  end

  # Pending
  def create; end

  def destroy; end
end
