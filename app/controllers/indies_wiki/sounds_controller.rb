class IndiesWiki::SoundsController < ApplicationController
  def create; end

  def destroy(id)
    RegisteredArtist::Sound.find(id).destroy!
    head :ok
  end
end
