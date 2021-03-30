# == Schema Information
#
# Table name: music_bars
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  place      :string           not null
#  hp         :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MusicBar < ApplicationRecord
  has_many :schedules, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :place, presence: true
  validates :hp, presence: true, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w(http https))}\z/
end
