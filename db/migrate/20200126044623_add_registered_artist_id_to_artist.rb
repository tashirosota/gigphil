class AddRegisteredArtistIdToArtist < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :registered_artist_id, :integer, foreign_key: true
    add_index :artists, :registered_artist_id, unique: true
  end
end
