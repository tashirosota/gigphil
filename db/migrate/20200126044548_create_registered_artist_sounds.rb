class CreateRegisteredArtistSounds < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artist_sounds do |t|
      t.references :registered_artist, foreign_key: true, null: false
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
