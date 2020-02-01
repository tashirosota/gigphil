# == Schema Information
#
# Table name: registered_artist_histories
#
#  id                   :bigint           not null, primary key
#  editor_id            :bigint           not null
#  registered_artist_id :bigint           not null
#  old_name             :string           not null
#  old_hp               :string
#  old_description      :string
#  old_area             :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class RegisteredArtist::History < ApplicationRecord
  belongs_to :editor, class_name: 'User'
  belongs_to :registerd_artist, class_name: 'RegisteredArtist'
end
