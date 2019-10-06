class CreateMusicBars < ActiveRecord::Migration[6.0]
  def change
    create_table :music_bars do |t|
      t.string :name, null: false, index: true
      t.string :place
      t.timestamps
    end
  end
end
