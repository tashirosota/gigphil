class CreateFavoriteArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_artists do |t|
      t.references :registered_artist, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end

    add_index :favorite_artists, [:user_id, :registered_artist_id], unique: true
  end
end
