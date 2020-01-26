class CreateTimeTables < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tables do |t|
      t.references :user, foreign_key: true, null: false
      t.string :uuid, null: false, index: { unique: true }
      t.string :title, null: false
      t.string :place
      t.text :memo
      t.datetime :event_date, null: false
      t.datetime :meeting_time, null: false
      t.datetime :open_time, null: false
      t.datetime :start_time, null: false
      t.integer :rehearsal_setting_time 
      t.integer :rehearsal_play_time 
      t.integer :production_setting_time 
      t.integer :production_play_time 
      t.timestamps
    end
  end
end
