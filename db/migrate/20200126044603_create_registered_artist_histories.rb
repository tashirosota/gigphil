class CreateRegisteredArtistHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artist_histories do |t|
      t.references :editor, foreign_key: { to_table: :users }, null: false
      t.references :registered_artist, foreign_key: true, null: false
      t.string :old_name, null: false
      t.string :old_hp
      t.string :old_description
      t.string :old_area, null: false
      
      t.timestamps
    end
  end
end
