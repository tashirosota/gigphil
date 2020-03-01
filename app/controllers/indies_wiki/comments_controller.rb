class IndiesWiki::CommentsController < ApplicationController
  skip_before_action :authenticate!, only: :index
  def index
    artist = RegisteredArtist.find(params[:id])
    artist.create_forum! unless artist.forum
    @comments = artist.forum.comments
  end

  def create; end

  def destroy(id)
    RegisteredArtist::Forum::Comment.find(id).destroy!
    head :ok
  end
end
