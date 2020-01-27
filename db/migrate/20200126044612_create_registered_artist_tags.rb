class CreateRegisteredArtistTags < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artist_tags do |t|
      t.references :registered_artist, foreign_key: true, null: false
      t.string :name, unique: true, null: false

      t.timestamps
    end
    add_index :registered_artist_tags, :name, unique: true
  end
end
