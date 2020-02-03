class IndiesWiki::ForumsController < ApplicationController
  def create(artist_id)
    RegisteredArtist::Forum.create!(registered_artist_id: artist_id)
    redirect_to indies_wiki_artist_forum_comments_path(artist_id)
  end
end
