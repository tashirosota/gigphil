class CreateRegisteredArtistForumComments < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_artist_forum_comments do |t|
      t.references :registered_artist_forums, index: { name: 'forum_comment_index' }, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :display_name, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
