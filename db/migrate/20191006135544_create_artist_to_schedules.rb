class CreateArtistToSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_to_schedules do |t|
      t.references :artist, foreign_key: true, null: false
      t.references :schedule, foreign_key: true, null: false
      t.timestamps
    end
  end
end
