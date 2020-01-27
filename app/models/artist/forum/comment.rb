# == Schema Information
#
# Table name: artist_forum_comments
#
#  id               :bigint           not null, primary key
#  artist_forums_id :bigint           not null
#  user_id          :bigint           not null
#  desplay_name     :string           not null
#  body             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Artist::Forum::Comment < ApplicationRecord
end
