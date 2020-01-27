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
end
