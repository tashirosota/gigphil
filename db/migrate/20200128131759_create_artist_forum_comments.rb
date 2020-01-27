class CreateArtistForumComments < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_forum_comments do |t|
      t.references :artist_forums, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :desplay_name, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
