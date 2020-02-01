# == Schema Information
#
# Table name: registered_artist_forum_comments
#
#  id                         :bigint           not null, primary key
#  registered_artist_forum_id :bigint           not null
#  user_id                    :bigint           not null
#  display_name               :string
#  body                       :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class RegisteredArtist::Forum::Comment < ApplicationRecord
  belongs_to :forum,
             class_name: 'RegisteredArtist::Forum',
             foreign_key: 'registered_artist_forum_id',
             inverse_of: :comments
  belongs_to :user, class_name: 'User'
end
