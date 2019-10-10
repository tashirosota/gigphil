class CreateMusicBars < ActiveRecord::Migration[6.0]
  def change
    create_table :music_bars do |t|
      t.string :name, null: false, index: true
      t.string :place, null: false
      t.string :hp, null: false
      t.timestamps
    end
  end
end