class CreateTimeTableRehearsals < ActiveRecord::Migration[6.0]
  def change
    create_table :time_table_rehearsals do |t|
      t.references :time_table, foreign_key: true, null: false
      t.integer :order, null: false
      t.string :band_name, null: false
      t.integer :custom_play_time 
      t.integer :custom_setting_time 
      t.string :memo 
      t.timestamps
    end
  end
end
