class CreateRegisteredArtistForums < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artist_forums do |t|
      t.references :registered_artist, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :display_name, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
