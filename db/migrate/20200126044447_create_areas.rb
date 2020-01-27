class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name, unique: true, null: false

      t.timestamps
    end
    add_index :areas, :name, unique: true
  end
end
