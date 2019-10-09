class CreateUserToSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :user_to_schedules do |t|
      t.references :user, foreign_key: true, null: false
      t.references :schedule, foreign_key: true, null: false
      t.timestamps
    end
  end
end
