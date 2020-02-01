# == Schema Information
#
# Table name: registered_artist_forums
#
#  id                   :bigint           not null, primary key
#  registered_artist_id :bigint           not null
#  user_id              :bigint           not null
#  display_name         :string           not null
#  body                 :text             not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class RegisteredArtist::Forum < ApplicationRecord
  has_many :comments, class_name: 'RegisteredArtist::Forum::Comment', dependent: :destroy
end
