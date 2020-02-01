# == Schema Information
#
# Table name: registered_artists
#
#  id                 :bigint           not null, primary key
#  area_id            :bigint           not null
#  registered_user_id :bigint           not null
#  name               :string           not null
#  icon               :string           not null
#  hp                 :string
#  twitter            :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RegisteredArtist < ApplicationRecord
  mount_uploader :icon, IconUploader
  has_many :tag_to_registered_artists, class_name: 'TagToRegisteredArtist', dependent: :destroy
  has_many :tags, through: :tag_to_registered_artists
  has_many :edit_histories, class_name: 'RegisteredArtist::History', dependent: :destroy
  has_many :sounds, class_name: 'RegisteredArtist::Sound', dependent: :destroy
  has_one :forum, class_name: 'RegisteredArtist::Forum', dependent: :
  belongs_to :user
end
