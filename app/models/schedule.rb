# == Schema Information
#
# Table name: schedules
#
#  id           :integer          not null, primary key
#  music_bar_id :integer          not null
#  title        :string           not null
#  event_date   :datetime         not null
#  open         :datetime
#  start        :datetime
#  adv          :integer
#  door         :integer
#  info         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Schedule < ApplicationRecord
  has_many :artist_to_schedule, class_name: '::ArtistToSchedule', dependent: :destroy
  has_many :artists, through: :artist_to_schedule
  has_many :user_to_schedule, class_name: '::UserToSchedule', dependent: :destroy
  has_many :users, through: :user_to_schedule

  validates :adv, numericality: { only_integer: true, greater_than_equal_to: 0, allow_blank: true }
  validates :door, numericality: { only_integer: true, greater_than_equal_to: 0, allow_blank: true }
end
