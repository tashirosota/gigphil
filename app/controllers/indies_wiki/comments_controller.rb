class IndiesWiki::CommentsController < ApplicationController
  def index(artist_id)
    comments = RegisteredArtist::Forum.find(artist_id).comments
    render json: comments # シリアライザー挟む
  end

  def create; end

  def destroy(id)
    RegisteredArtist::Forum::Comment.find(id).destroy!
    head :ok
  end
end
