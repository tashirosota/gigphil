class CreateTagToRegisteredArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_to_registered_artists do |t|
      t.references :registered_artist, foreign_key: true, null: false
      t.references :registered_artist_tag, foreign_key: true, null: false

      t.timestamps
    end
    add_index :tag_to_registered_artists, [:registered_artist_id, :registered_artist_tag_id], unique: true, name: 'tag_to_registered_artist_index'
  end
end
