# == Schema Information
#
# Table name: time_tables
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  uuid                    :string           not null
#  title                   :string           not null
#  place                   :string
#  memo                    :text
#  event_date              :datetime         not null
#  meeting_time            :datetime         not null
#  open_time               :datetime         not null
#  start_time              :datetime         not null
#  rehearsal_setting_time  :integer
#  rehearsal_play_time     :integer
#  production_setting_time :integer
#  production_play_time    :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class TimeTable < ApplicationRecord
  belongs_to :user
  has_many :rehearsals, class_name: 'TimeTable::Rehearsal'
  has_many :concerts, class_name: 'TimeTable::Consert'

  def to_hash # にじみ出るoverride感
    {
      uuid: uuid,
      eventDate: event_date.strftime('%Y:%m'),
      title: title,
      place: place,
      memo: memo,
      meetingTime: meeting_time.strftime('%H:%M'),
      openTime: open_time.strftime('%H:%M'),
      startTime: start_time.strftime('%H:%M'),
      rehearsalSettingTime: rehearsal_setting_time,
      rehearsalPlayTime: rehearsal_play_time,
      productionSettingTime: production_setting_time,
      productionPlayTime: production_play_time,
      rehearsals: rehearsals.map do |record|
        order: record.order,
        bandName: record.band_name,
        customPlayTime: record.custom_play_time,
        customSettingTime: record.custom_setting_time,
        memo:  record.memo
      end, 
      concerts: concerts.map do |record|
        order: record.order,
        bandName: record.band_name,
        customPlayTime: record.custom_play_time,
        customSettingTime: record.custom_setting_time,
        memo:  record.memo
      end,
   }
    
  end

  def self.default_hash
      {
         eventDate: '2020-10-01',
         title: 'タイトル',
         place: '場所',
         memo: '備考',
         meetingTime: '17:30',
         openTime: '18:00',
         startTime: '18:30',
         rehearsalSettingTime: 5,
         rehearsalPlayTime: 20,
         productionSettingTime: 10,
         productionPlayTime: 30,
         rehearsals: Array.new(6).map.with_index do | _, i |
          {
            order: i + 1,
            bandName: 'バンド名',
            customPlayTime: nil,
            customSettingTime: nil,
            memo: '備考'
          }
         end, 
         concerts: Array.new(6).map.with_index do | _, i |
          {
            order: i + 1,
            bandName: 'バンド名',
            customPlayTime: nil,
            customSettingTime: nil,
            memo: '備考'
          }
         end
      }
  end
end
