# == Schema Information
#
# Table name: schedules
#
#  id           :bigint           not null, primary key
#  music_bar_id :bigint           not null
#  title        :string           not null
#  event_date   :datetime         not null
#  info         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Schedule < ApplicationRecord
  belongs_to :music_bar

  has_many :artist_to_schedules, class_name: '::ArtistToSchedule', dependent: :destroy
  has_many :artists, through: :artist_to_schedules
  has_many :user_to_schedules, class_name: '::UserToSchedule', dependent: :destroy
  has_many :users, through: :user_to_schedules

  validates :title, presence: true, uniqueness: { scope: %i(music_bar_id event_date) }
  validates :event_date, presence: true

  scope :today, -> do
    Schedule.includes(:music_bar, :artists)
            .where(event_date: Time.zone.now.all_day)
            .order(music_bar_id: :asc)
  end

  scope :tomorrow, -> do
    Schedule.includes(:music_bar, :artists)
            .where(event_date: (Time.zone.now + 1.day).all_day)
            .order(music_bar_id: :asc)
  end

  # 以下serializer用

  def music_bar_model
    {
      name: music_bar.name,
      hp: music_bar.hp,
      place: music_bar.place
    }
  end

  def artist_names
    artists.map { |artist| artist.name.gsub(/[\r\n\t]/, '') }
  end
end
