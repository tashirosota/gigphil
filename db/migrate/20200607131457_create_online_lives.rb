class CreateOnlineLives < ActiveRecord::Migration[6.0]
  def change
    create_table :online_lives do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :url, null: false
      t.boolean :is_free, null: false, default: false
      t.datetime :broadcasts_at, null: false
      t.timestamps
    end
  end
end
