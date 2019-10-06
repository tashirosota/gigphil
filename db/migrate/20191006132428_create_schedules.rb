class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :music_bar, foreign_key: true, null: false
      t.datetime :date, null: false, index: true
      t.datetime :open
      t.datetime :start
      t.string :adv
      t.string :door
      t.string :info, null: false
      t.timestamps
    end
  end
end
