class AddMvToArtist < ActiveRecord::Migration[6.0]
  def change
    add_column :registered_artists, :mv, :string, after: :description
  end
end
