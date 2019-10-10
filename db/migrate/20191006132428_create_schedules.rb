class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :music_bar, foreign_key: true, null: false
      t.string :title, null: false, index: true
      t.datetime :event_date, null: false, index: true
      t.datetime :open
      t.datetime :start
      t.integer :adv
      t.integer :door
      t.text :info
      t.timestamps
    end
  end
end