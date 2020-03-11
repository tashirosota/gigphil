class CreateRegisteredArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artists do |t|
      t.references :area, foreign_key: true, null: false
      t.references :registered_user, foreign_key: { to_table: :users }, null: false
      t.string :name, unique: true, null: false
      t.string :icon, null: false
      t.string :hp
      t.string :twitter
      t.text :description

      t.timestamps
    end
    add_index :registered_artists, :name, unique: true
  end
end
