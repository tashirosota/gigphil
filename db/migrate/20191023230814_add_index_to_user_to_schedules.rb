class AddIndexToUserToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_index :user_to_schedules, [:user_id, :schedule_id], unique: true
  end
end
