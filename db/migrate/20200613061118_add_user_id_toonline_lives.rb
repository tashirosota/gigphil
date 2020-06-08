class AddUserIdToonlineLives < ActiveRecord::Migration[6.0]
  def change
    add_reference :online_lives, :user, index: true
  end
end
