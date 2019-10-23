class AddIndexToArtistToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_index :artist_to_schedules, [:artist_id, :schedule_id], unique: true
  end
end
