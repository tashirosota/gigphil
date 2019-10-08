# == Schema Information
#
# Table name: music_bars
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  place      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MusicBar < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
