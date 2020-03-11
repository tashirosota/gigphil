class AddIconToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :icon_url, :string, after: :username
  end
end
