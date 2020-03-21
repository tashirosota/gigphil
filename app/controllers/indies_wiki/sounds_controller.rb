class IndiesWiki::SoundsController < ApplicationController
  def create
    sound = RegisteredArtist::Sound.create! sound_params

    rendar json: {
      id: sound.id,
      title: sound.title,
      url: sound.url
    }
  end

  def destroy(id)
    RegisteredArtist::Sound.find(id).destroy!
    head :ok
  end

  private

  def sound_params
    params[:sound].permit(:registered_artist_id, :title, :url)
  end
end
