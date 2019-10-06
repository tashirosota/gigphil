class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :access_token_hash, null: false, index: { unique: true }
      t.string :refresh_token_hash, null: false, index: { unique: true }
      t.datetime :token_expires_at, null: false
      t.timestamps
    end
  end
end
